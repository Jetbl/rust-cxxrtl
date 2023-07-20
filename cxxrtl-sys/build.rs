extern crate bindgen;

use std::env;
use std::path::{Path, PathBuf};
use std::process::Command;

fn main() {
    let output = Command::new("yosys-config")
        .args(["--datdir/include"])
        .output()
        .expect("failed to get yosys include dir");
    let include = String::from_utf8_lossy(&output.stdout);

    // Tell cargo to invalidate the built crate whenever the wrapper changes
    println!("cargo:rerun-if-changed=wrapper.h");

    // The bindgen::Builder is the main entry point
    // to bindgen, and lets you build up options for
    // the resulting bindings.
    let bindings = bindgen::Builder::default()
        .clang_arg(format!("-I{}", include.trim()))
        // The input header we would like to generate
        // bindings for.
        .header("wrapper.h")
        // Tell cargo to invalidate the built crate whenever any of the
        // included header files changed.
        .parse_callbacks(Box::new(bindgen::CargoCallbacks))
        // Finish the builder and generate the bindings.
        .generate()
        // Unwrap the Result and panic on failure.
        .expect("Unable to generate bindings");

    // Write the bindings to the $OUT_DIR/bindings.rs file.
    let out_path = PathBuf::from(env::var("OUT_DIR").unwrap());
    bindings
        .write_to_file(out_path.join("bindings.rs"))
        .expect("Couldn't write bindings!");

    let capi = Path::new(include.trim()).join("backends/cxxrtl/cxxrtl_capi.cc");
    let vcd_capi = Path::new(include.trim()).join("backends/cxxrtl/cxxrtl_vcd_capi.cc");
    cc::Build::new()
        .include(include.trim())
        .cpp(true)
        .file(capi)
        .file(vcd_capi)
        .flag_if_supported("-std=c++14")
        .compile("cxxrtl");
}
