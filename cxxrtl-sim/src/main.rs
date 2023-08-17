use clap::Parser;
use cxxrtl::{CxxrtlHandle, CxxrtlSignal, Vcd, _cxxrtl_toplevel};
use futures::future::{self, Either};
use futures::pin_mut;
use serde::ser::SerializeMap;
use serde::{Deserialize, Serialize};
use std::sync::atomic::{AtomicUsize, Ordering};
use std::sync::Arc;
use std::{
    collections::HashMap,
    error::Error,
    ffi::OsStr,
    fs::File,
    path::{Path, PathBuf},
    process::Command,
    slice::Iter,
};
use tokio::sync::broadcast::{Receiver, Sender};
use tokio::task::JoinError;
use tokio::{runtime, task};

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

    /// Sets the randomize
    #[arg(long)]
    randomize: Option<usize>,

    /// Sets the number of reset cycles
    #[arg(long, default_value_t = 3)]
    reset_cycles: usize,

    /// Sets the number of max cycles
    #[arg(long, default_value_t = 10000)]
    max_cycles: usize,

    /// Generates a vcd file
    #[arg(long)]
    vcd: bool,
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

#[derive(Deserialize)]
struct Interface {
    #[serde(flatten)]
    event: Event,
    name: String,
    #[serde(skip)]
    cxxrtl_signal: Option<CxxrtlSignal<1>>,
}

#[derive(Deserialize)]
struct Interfaces {
    interfaces: Vec<Interface>,
    inputs: Vec<Signal>,
    outputs: Vec<Signal>,
}

impl Interfaces {
    fn validate(&self) {
        assert!(self.interfaces.len() > 0, "No interfaces defined");
        assert!(
            self.interfaces.len() == 1,
            "Unsupported: multiple interfaces"
        );
    }

    fn set_cxxrtl_signals(&mut self, dut: &Dut) {
        for interface in &mut self.interfaces {
            if !interface.event.phantom {
                interface.cxxrtl_signal = dut.handle.get(&interface.name).map(|o| o.signal());
            }
        }
        for signal in &mut self.inputs {
            signal.cxxrtl_signal = dut.handle.get(&signal.name).map(|o| {
                assert!(signal.width == o.width as usize && signal.width <= 32);
                o.signal()
            });
        }
        for signal in &mut self.outputs {
            signal.cxxrtl_signal = dut.handle.get(&signal.name).map(|o| {
                assert!(signal.width == o.width as usize && signal.width <= 32);
                o.signal()
            });
        }
    }
}

#[derive(Deserialize, Debug)]
struct Interval {
    event: String,
    start: usize,
    end: usize,
}

#[derive(Deserialize)]
struct Signal {
    name: String,
    width: usize,
    #[serde(flatten)]
    interval: Interval,
    #[serde(skip)]
    cxxrtl_signal: Option<CxxrtlSignal<32>>,
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
    handle: Arc<CxxrtlHandle>,
}

impl Dut {
    fn new<P: AsRef<OsStr>>(lib: P) -> Self {
        let handle = unsafe {
            let lib = libloading::Library::new(lib).unwrap();
            let func: libloading::Symbol<unsafe extern "C" fn() -> *mut _cxxrtl_toplevel> =
                lib.get(b"cxxrtl_design_create").unwrap();
            let top = func();
            std::mem::forget(lib);
            CxxrtlHandle::new(top)
        };

        Self {
            handle: Arc::new(handle),
        }
    }
}

#[derive(Clone, Debug, PartialEq, Eq)]
enum ClockEdge {
    Rising,
    Falling,
}

struct Driver {
    handle: Arc<CxxrtlHandle>,
    clk: CxxrtlSignal<1>,
    reset: CxxrtlSignal<1>,
    vcd: Option<Vcd>,
}

impl Driver {
    fn new(handle: Arc<CxxrtlHandle>, vcd: Option<Vcd>) -> Option<Self> {
        let clk = handle.get("clk")?.signal();
        let reset = handle.get("reset")?.signal::<1>();
        Some(Self {
            handle,
            clk,
            reset,
            vcd,
        })
    }
    async fn reset(&mut self, mut reset_cycles: usize) {
        self.reset.set(true);
        while reset_cycles > 0 {
            self.clk.set(false);
            self.handle.step();
            self.clk.set(true);
            self.handle.step();
            reset_cycles -= 1;
        }
        self.reset.set(false);
    }

    async fn start(&mut self, tx: Sender<ClockEdge>, max_cycles: usize, count: Arc<AtomicUsize>) {
        if let Some(vcd) = &mut self.vcd {
            vcd.sample(0);
        }
        for i in 0..max_cycles {
            // falling edge
            self.clk.set(false);
            while let Err(_) = tx.send(ClockEdge::Falling) {
                task::yield_now().await;
            }
            task::yield_now().await;
            self.handle.step();
            if let Some(vcd) = &mut self.vcd {
                vcd.sample(i as u64 * 2);
            }

            // rigsing edge
            self.clk.set(true);
            while let Err(_) = tx.send(ClockEdge::Rising) {
                task::yield_now().await;
            }
            task::yield_now().await;
            self.handle.step();
            if let Some(vcd) = &mut self.vcd {
                vcd.sample(i as u64 * 2 + 1);
                let stdout = std::io::stdout().lock();
                vcd.write(stdout).unwrap();
            }
            count.fetch_add(1, Ordering::Relaxed);
        }
    }
}

fn main() -> Result<(), Box<dyn Error>> {
    let cli = Cli::parse();
    let out = std::env::temp_dir().join("cxxrtl-sim");
    if !out.exists() {
        std::fs::create_dir(&out)?;
    }

    let data_file = File::open(cli.data_file)?;
    let data: DataInput = serde_json::from_reader(data_file)?;
    data.validate();

    let source = cli.verilog_file;
    let builder = Builder::new();
    let file_name = source.file_stem().unwrap();
    let dest = out.join(file_name).with_extension("so");
    builder.build(&source, &dest)?;

    let interfaces_file = File::open(cli.interface_file)?;
    let mut interfaces: Interfaces = serde_json::from_reader(interfaces_file)?;
    interfaces.validate();
    let dut = Dut::new(&dest);
    interfaces.set_cxxrtl_signals(&dut);

    let rt = runtime::Builder::new_current_thread().build()?;
    let outputs = rt.block_on(async {
        let randomize = cli.randomize;
        let reset_cycles = cli.reset_cycles;
        let max_cycles = cli.max_cycles;

        let (clk_ch_tx, _) = tokio::sync::broadcast::channel(1);

        // setup the design
        for interface in &interfaces.interfaces {
            if !interface.event.phantom {
                interface.cxxrtl_signal.as_ref().unwrap().set(false);
            }
        }
        let vcd = cli.vcd.then(|| {
            let mut vcd = Vcd::new();
            vcd.timescale(cxxrtl::TimescaleNumber::One, cxxrtl::TimescaleUnit::Us);
            // vcd.add_without_memories(&blink.handle);
            vcd.add(&dut.handle);
            vcd
        });
        let mut driver = Driver::new(dut.handle.clone(), vcd).unwrap();
        driver.reset(reset_cycles).await;

        let count = Arc::new(AtomicUsize::new(0));

        let interfaces = Arc::new(interfaces);
        let clk_tx = clk_ch_tx.clone();
        // let main_handle = task::spawn(process(data, clk_ch_tx, interfaces, randomize));
        let main_handle = task::spawn(async move {
            let mut rx = clk_tx.subscribe();
            // New transaction should only trigger at the start of a cycle
            while rx.recv().await != Ok(ClockEdge::Rising) {}

            let mut outputs = vec![];
            let event = &interfaces.interfaces[0].event;

            for input in data.iter() {
                // spaw a one transaction input
                outputs.push(task::spawn(process_input(
                    input,
                    clk_tx.subscribe(),
                    interfaces.clone(),
                )));

                // compute a randomize delay
                let delay = event.delay
                    + if let Some(randomize) = randomize {
                        rand::random::<usize>() % randomize
                    } else {
                        0
                    };

                // wait for delay cycles
                for _ in 0..delay {
                    while rx.recv().await != Ok(ClockEdge::Rising) {}
                }
            }

            future::join_all(outputs).await
        });

        let clk_tx = clk_ch_tx.clone();
        let cycles_count = count.clone();
        // let clk_handle =
        //     tokio::spawn(async move { driver.start(clk_tx, max_cycles, cycles_count).await });
        let clk_handle = driver.start(clk_tx, max_cycles, cycles_count);
        pin_mut!(clk_handle);

        match future::select(clk_handle, main_handle).await {
            Either::Left((_, _)) => Err(count.load(Ordering::Relaxed)),
            Either::Right((outputs, _)) => {
                let outputs: Result<Vec<Output>, JoinError> =
                    outputs.unwrap().into_iter().collect();
                Ok((
                    outputs.unwrap(),
                    count.load(Ordering::Relaxed),
                    // driver.vcd_out,
                ))
            }
        }
    });

    let (outputs, count) = outputs.unwrap();
    if !cli.vcd {
        let mut data_outputs = DataOutput::new();
        data_outputs.extend(outputs.into_iter().enumerate());
        // also substract the 1 cycle it takes to propagate the go signal
        data_outputs.cycles = count - 1;
        print!("{}", serde_json::to_string(&data_outputs)?);
    }
    Ok(())
}

async fn process_input(
    input: Input,
    mut clk_rx: Receiver<ClockEdge>,
    interfaces: Arc<Interfaces>,
) -> Output {
    let interface = &interfaces.interfaces[0];
    let event = &interface.event;
    let mut output = Output::new();
    for st in 0..event.states {
        let trg = st == 0;
        if !event.phantom {
            interface.cxxrtl_signal.as_ref().unwrap().set(trg);
        }

        // Sets input values
        for inp in &interfaces.inputs {
            let interval = &inp.interval;
            assert!(interval.event == event.name);
            if st >= interval.start && st < interval.end {
                let value = input.input[&inp.name];
                inp.cxxrtl_signal.as_ref().unwrap().set(value);
            }
        }

        // Wait for the falling edge so that combinational computations
        // propagate.
        while clk_rx.recv().await != Ok(ClockEdge::Falling) {}

        // For each output, record the value if we expect it to be valid
        for out in &interfaces.outputs {
            let interval = &out.interval;
            assert!(interval.event == event.name);
            if st >= interval.start && st < interval.end {
                let value = out.cxxrtl_signal.as_ref().unwrap().get();
                output.insert(&out.name, value);
            }
        }

        // Wait for end of cycle
        while clk_rx.recv().await != Ok(ClockEdge::Rising) {}
    }

    output
}
