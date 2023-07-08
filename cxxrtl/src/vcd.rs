use std::io::Write;

use cxxrtl_sys::{
    cxxrtl_vcd_add_from_without_memories, cxxrtl_vcd_create, cxxrtl_vcd_destroy, cxxrtl_vcd_read,
    cxxrtl_vcd_sample, cxxrtl_vcd_timescale,
};

use crate::CxxrtlHandle;

#[derive(Clone, Copy)]
pub enum Timescale {
    Us(i32),
}

impl Timescale {
    fn values(&self) -> (i32, &'static str) {
        match *self {
            Timescale::Us(n) => (n, "us"),
        }
    }
}

pub struct Vcd {
    pub(crate) vcd: cxxrtl_sys::cxxrtl_vcd,
}
impl Vcd {
    pub fn new() -> Self {
        Vcd {
            vcd: unsafe { cxxrtl_vcd_create() },
        }
    }

    pub fn timescale(&mut self, scale: Timescale) {
        let (n, unit) = scale.values();
        unsafe { cxxrtl_vcd_timescale(self.vcd, n, unit.as_bytes().as_ptr() as *const _) }
    }

    pub fn add_without_memories(&mut self, handle: &CxxrtlHandle) {
        unsafe {
            cxxrtl_vcd_add_from_without_memories(self.vcd, handle.handle);
        }
    }

    pub fn sample(&mut self, time: u64) {
        unsafe {
            cxxrtl_vcd_sample(self.vcd, time);
        }
    }

    pub fn write<W: Write>(&mut self, mut w: W) -> std::io::Result<()> {
        let len: usize = 0;
        let data: usize = 0;

        let buf = unsafe {
            cxxrtl_vcd_read(
                self.vcd,
                &data as *const _ as *mut _,
                &len as *const _ as *mut _,
            );
            std::slice::from_raw_parts(data as *const _, len)
        };
        w.write_all(buf)
    }
}

impl Drop for Vcd {
    fn drop(&mut self) {
        unsafe { cxxrtl_vcd_destroy(self.vcd) };
    }
}
