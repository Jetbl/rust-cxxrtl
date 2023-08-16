use clap::Parser;
use cxxrtl::{CxxrtlHandle, CxxrtlSignal, _cxxrtl_toplevel};
use serde::ser::{SerializeMap, SerializeSeq};
use serde::{Deserialize, Serialize};
use std::{
    collections::HashMap,
    error::Error,
    ffi::OsStr,
    fs::File,
    path::{Path, PathBuf},
    process::Command,
    slice::Iter,
};

#[derive(Parser)]
struct Cli {
    /// Sets the verilog file
    #[arg(short, long, value_name = "FILE")]
    verilog_file: PathBuf,

    /// Sets the interface file
    #[arg(short, long, value_name = "INTERFACE_FILE")]
    interface_file: PathBuf,

    /// Sets the data file
    #[arg(short, long, value_name = "DATA_FILE")]
    data_file: PathBuf,
}

struct Builder {
    include: String,
    capi: PathBuf,
}

impl Builder {
    fn new() -> Self {
        let output = Command::new("yosys-config")
            .args(["--datdir/include"])
            .output()
            .expect("failed to get yosys include dir");
        let stdout = String::from_utf8_lossy(&output.stdout);
        let include = stdout.trim().to_string();
        let capi = Path::new(&include).join("backends/cxxrtl/cxxrtl_capi.cc");
        Self { include, capi }
    }

    fn build(&self, source: &PathBuf, dest: &PathBuf) -> Result<(), Box<dyn Error>> {
        let cc_file = dest.with_extension("cc");
        Command::new("yosys")
            .args([
                "-q",
                "-p",
                &format!(
                    "hierarchy -top main; write_cxxrtl -O0 {}",
                    cc_file.to_string_lossy()
                ),
            ])
            .arg(&source)
            .status()?;

        Command::new("clang++")
            .args(["-g", "-O3", "-fPIC", "-shared", "-std=c++14"])
            .arg(format!("-I{}", &self.include))
            .arg(&self.capi)
            .arg(cc_file)
            .arg("-o")
            .arg(dest)
            .status()?;

        Ok(())
    }
}

#[derive(Deserialize, Debug)]
struct Event {
    #[serde(rename(deserialize = "event"))]
    name: String,
    delay: usize,
    states: usize,
    phantom: bool,
}

#[derive(Deserialize, Debug)]
struct Interface {
    #[serde(flatten)]
    event: Event,
    name: String,
}

#[derive(Deserialize, Debug)]
struct Interfaces {
    interfaces: Vec<Interface>,
    inputs: Vec<Signal>,
    outputs: Vec<Signal>,
}

impl Interfaces {
    fn validate(&self) {
        assert!(self.interfaces.len() > 0, "blabla");
        assert!(self.interfaces.len() == 1, "blabla");
    }
}

#[derive(Deserialize, Debug)]
struct Interval {
    event: String,
    start: usize,
    end: usize,
}

#[derive(Deserialize, Debug)]
struct Signal {
    name: String,
    width: usize,
    #[serde(flatten)]
    interval: Interval,
}

#[derive(Deserialize, Debug)]
struct DataInput {
    #[serde(flatten)]
    inputs: HashMap<String, Vec<u32>>,
}

impl DataInput {
    fn validate(&self) {
        let mut values = self.inputs.values();
        let len = values.next().unwrap().len();
        assert!(values.all(|v| v.len() == len));
    }

    fn iter(&self) -> DataInputIter<'_> {
        let data = self
            .inputs
            .iter()
            .map(|(k, v)| (k.clone(), v.iter()))
            .collect();
        DataInputIter { data }
    }
}

struct DataInputIter<'a> {
    data: HashMap<String, Iter<'a, u32>>,
}

impl<'a> Iterator for DataInputIter<'a> {
    type Item = Input;

    fn next(&mut self) -> Option<Self::Item> {
        let values = self.data.iter_mut().map(|(k, v)| (k, v.next()));
        Input::new(values)
    }
}

#[derive(Debug)]
struct Input {
    input: HashMap<String, u32>,
}

impl Input {
    fn new<'a, I: Iterator<Item = (&'a String, Option<&'a u32>)>>(iter: I) -> Option<Self> {
        let mut input = HashMap::new();
        for (k, v) in iter {
            let v = v?;
            let val = input.entry(k.clone()).or_insert(0);
            *val = *v;
        }
        Some(Self { input })
    }
}

#[derive(Debug, Default)]
struct Values {
    values: Vec<(usize, u32)>,
}

impl Serialize for Values {
    fn serialize<S>(&self, serializer: S) -> Result<S::Ok, S::Error>
    where
        S: serde::Serializer,
    {
        let mut map = serializer.serialize_map(Some(self.values.len()))?;
        for (t, v) in &self.values {
            map.serialize_entry(&t.to_string(), &vec![v])?;
        }
        map.end()
    }
}

#[derive(Serialize, Debug)]
struct DataOutput {
    #[serde(flatten)]
    output: HashMap<String, Values>,
    cycles: usize,
}

impl DataOutput {
    fn new() -> Self {
        Self {
            output: Default::default(),
            cycles: 0,
        }
    }
}

impl Extend<(usize, Output)> for DataOutput {
    fn extend<T: IntoIterator<Item = (usize, Output)>>(&mut self, iter: T) {
        for (t, output) in iter {
            for (k, v) in output.output {
                let values = self.output.entry(k).or_insert(Default::default());
                values.values.push((t, v));
            }
        }
    }
}

#[derive(Debug)]
struct Output {
    output: HashMap<String, u32>,
}

impl Output {
    fn new() -> Self {
        Self {
            output: HashMap::new(),
        }
    }

    fn insert(&mut self, name: &String, value: u32) {
        self.output.insert(name.clone(), value);
    }
}

struct Dut {
    handle: CxxrtlHandle,
    clk: CxxrtlSignal<1>,
    interfaces: Interfaces,
    cycles: usize,
}

impl Dut {
    fn new<P: AsRef<OsStr>>(lib: P, interfaces: Interfaces) -> Self {
        let handle = unsafe {
            let lib = libloading::Library::new(lib).unwrap();
            let func: libloading::Symbol<unsafe extern "C" fn() -> *mut _cxxrtl_toplevel> =
                lib.get(b"cxxrtl_design_create").unwrap();
            let top = func();
            std::mem::forget(lib);
            CxxrtlHandle::new(top)
        };

        let clk = handle.get("clk").unwrap().signal();
        Self {
            handle,
            clk,
            interfaces,
            cycles: 0,
        }
    }

    fn process(&mut self, input: Input) -> Output {
        println!("{input:?}");
        let interface = &self.interfaces.interfaces[0];
        let event = &interface.event;
        let mut output = Output::new();
        for st in 0..event.states {
            let trg = st == 0;
            if !event.phantom {
                self.handle
                    .get(&interface.name)
                    .expect(&format!("cannot found interface {}", &event.name))
                    .signal::<1>()
                    .set(trg);
            }

            // Sets input values
            for inp in &self.interfaces.inputs {
                let interval = &inp.interval;
                assert!(interval.event == event.name);
                if st >= interval.start && st < interval.end {
                    let value = input.input[&inp.name];
                    self.handle
                        .get(&inp.name)
                        .expect(&format!("cannot found signal for input {}", &inp.name))
                        .signal::<32>()
                        .set(value);
                }
            }

            // Wait for the falling edge so that combinational computations
            // propagate.
            self.clk.set(false);
            self.handle.step();

            // For each output, record the value if we expect it to be valid
            for out in &self.interfaces.outputs {
                let interval = &out.interval;
                assert!(interval.event == event.name);
                if st >= interval.start && st < interval.end {
                    let value = self
                        .handle
                        .get(&out.name)
                        .expect(&format!("cannot found signal for input {}", &out.name))
                        .signal::<32>()
                        .get();

                    output.insert(&out.name, value);
                }
            }

            // Wait for end of cycle
            self.clk.set(true);
            self.handle.step();
            self.cycles += 1;
        }

        output
    }
}

fn main() -> Result<(), Box<dyn Error>> {
    let cli = Cli::parse();
    let out = std::env::temp_dir().join("cxxrtl-sim");
    if !out.exists() {
        std::fs::create_dir(&out)?;
    }

    let interfaces_file = File::open(cli.interface_file)?;
    let interfaces: Interfaces = serde_json::from_reader(interfaces_file)?;
    interfaces.validate();

    let data_file = File::open(cli.data_file)?;
    let data: DataInput = serde_json::from_reader(data_file)?;
    data.validate();

    let source = cli.verilog_file;
    let builder = Builder::new();
    let file_name = source.file_stem().unwrap();
    let dest = out.join(file_name).with_extension("so");
    builder.build(&source, &dest)?;

    let mut dut = Dut::new(&dest, interfaces);
    let mut outputs = DataOutput::new();

    println!("{data:?}");
    outputs.extend(data.iter().map(|input| dut.process(input)).enumerate());
    outputs.cycles = dut.cycles;
    let res = serde_json::to_string(&outputs)?;
    println!("{outputs:?}");
    println!("{res:?}");
    Ok(())
}

// {
// "interfaces": [
// {"name": "go", "event": "G", "delay": 3, "states": 2, "phantom": false }
// ],
// "inputs": [
// { "event": "G", "name": "left", "width": 32 , "start": 0, "end": 1 },
// { "event": "G", "name": "right", "width": 32 , "start": 0, "end": 1 }
// ],
// "outputs": [
// { "event": "G", "name": "out", "width": 32 , "start": 1, "end": 2 }
// ]
// }
// }
