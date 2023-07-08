use std::{
    ffi::{c_char, c_int, c_void, CStr, CString},
    io::Write,
};

use cxxrtl_sys::{
    cxxrtl_object, cxxrtl_vcd_add_from, cxxrtl_vcd_add_from_if,
    cxxrtl_vcd_add_from_without_memories, cxxrtl_vcd_create, cxxrtl_vcd_destroy, cxxrtl_vcd_read,
    cxxrtl_vcd_sample, cxxrtl_vcd_timescale,
};

use crate::{CxxrtlHandle, CxxrtlObject};

#[derive(Clone, Copy, Debug)]
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

pub trait FilterClosure: FnMut(&str, CxxrtlObject) -> bool {}

pub struct Vcd {
    vcd: cxxrtl_sys::cxxrtl_vcd,
}

impl Vcd {
    pub fn new() -> Self {
        Vcd {
            vcd: unsafe { cxxrtl_vcd_create() },
        }
    }

    pub fn timescale(&mut self, scale: Timescale) {
        let (n, unit) = scale.values();
        let unit = CString::new(unit).unwrap();
        unsafe { cxxrtl_vcd_timescale(self.vcd, n, unit.as_bytes().as_ptr() as *const _) }
    }

    pub fn add(&mut self, handle: &CxxrtlHandle) {
        unsafe {
            cxxrtl_vcd_add_from(self.vcd, handle.handle);
        }
    }

    pub fn add_if<F>(&mut self, handle: &CxxrtlHandle, mut f: F)
    where
        F: FilterClosure,
    {
        type Filter = unsafe extern "C" fn(
            data: *mut c_void,
            name: *const c_char,
            object: *const cxxrtl_object,
        ) -> c_int;

        unsafe extern "C" fn trampoline<F>(
            data: *mut c_void,
            name: *const c_char,
            object: *const cxxrtl_object,
        ) -> c_int
        where
            F: FilterClosure,
        {
            let f = &mut *(data as *mut F);
            let name = CStr::from_ptr(name);
            let obj = CxxrtlObject::new(object as *mut _);
            let ret = f(name.to_str().unwrap(), obj);
            ret as i32 as _
        }

        pub fn get_filter<F>(_closure: &F) -> Filter
        where
            F: FilterClosure,
        {
            trampoline::<F>
        }

        let filter = get_filter(&f);
        let data = &mut f as *mut _ as *mut c_void;
        unsafe {
            cxxrtl_vcd_add_from_if(self.vcd, handle.handle, data, Some(filter));
        }
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
