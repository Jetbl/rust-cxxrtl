use cxxrtl_sys::{
    _cxxrtl_handle, _cxxrtl_toplevel, cxxrtl_create, cxxrtl_destroy,
    cxxrtl_flag_CXXRTL_DRIVEN_COMB, cxxrtl_flag_CXXRTL_DRIVEN_SYNC, cxxrtl_flag_CXXRTL_INPUT,
    cxxrtl_flag_CXXRTL_OUTPUT, cxxrtl_flag_CXXRTL_UNDRIVEN, cxxrtl_get, cxxrtl_object, cxxrtl_step,
};
use std::ffi::CString;
use std::marker::PhantomData;

use crate::UInt;

struct Assert<I: UInt, const N: u32> {
    _marker: PhantomData<I>,
}

impl<I: UInt, const N: u32> Assert<I, N> {
    const GE: () = assert!(I::BITS >= N, "Greater or equals");
}

pub struct Value<const N: u32> {
    data: &'static mut [u32],
}

impl<const N: u32> Value<N> {
    const CHUNKS: u32 = (N + u32::BITS - 1) / u32::BITS;

    pub unsafe fn new(data: *mut u32) -> Self {
        // dbg!(data);
        Self {
            data: std::slice::from_raw_parts_mut(data, Value::<N>::CHUNKS as usize),
        }
    }

    pub fn set<I: UInt>(&mut self, val: I) {
        let _ = Assert::<I, N>::GE;
        for n in 0..Self::CHUNKS {
            let chunk_val = val.get_chunk(n);
            self.data[n as usize] = chunk_val;
        }
    }

    pub fn get<I: UInt + Default>(&self) -> I {
        let _ = Assert::<I, N>::GE;
        let mut result = I::default();
        for n in 0..Self::CHUNKS {
            let chunk_val = self.data[n as usize];
            result.set_chunk(n, chunk_val);
        }
        result
    }
}

#[derive(Clone, Copy, Debug)]
#[repr(u32)]
pub enum CxxrtlType {
    Value,
    Wire,
    Memory,
    Alias,
    Outline,
}

#[derive(Clone, Copy, Debug)]
pub enum CxxrtlFlag {
    Input,
    Output,
    Sync,
    Comb,
    Undriven,
}

pub struct CxxrtlObject<const N: u32> {
    // obj: *mut cxxrtl_object,
    curr: Value<N>,
    next: Option<Value<N>>,
    // flags: Vec<CxxrtlFlag>,
}

impl<const N: u32> CxxrtlObject<N> {
    pub fn new(obj: *mut cxxrtl_object) -> Self {
        let width = unsafe { (*obj).width };
        debug_assert!(N as u64 == width);
        let type_ = unsafe { std::mem::transmute::<u32, CxxrtlType>((*obj).type_) };
        dbg!(type_);
        let flags = Self::flags(unsafe { (*obj).flags });
        dbg!(&flags);
        let lsb = unsafe { (*obj).lsb_at };
        assert!(lsb == 0);

        let curr = unsafe { Value::new((*obj).curr) };
        let next = (unsafe { *obj }).next;
        let next = (!next.is_null()).then_some(unsafe { Value::new(next) });

        Self {
            // obj,
            curr,
            next, // flags,
        }
    }

    fn flags(flags: u32) -> Vec<CxxrtlFlag> {
        let all_flags = [
            (cxxrtl_flag_CXXRTL_INPUT, CxxrtlFlag::Input),
            (cxxrtl_flag_CXXRTL_OUTPUT, CxxrtlFlag::Output),
            (cxxrtl_flag_CXXRTL_DRIVEN_SYNC, CxxrtlFlag::Sync),
            (cxxrtl_flag_CXXRTL_DRIVEN_COMB, CxxrtlFlag::Comb),
            (cxxrtl_flag_CXXRTL_UNDRIVEN, CxxrtlFlag::Undriven),
        ];

        all_flags
            .iter()
            .filter_map(|(f, c)| ((flags & f) != 0).then_some(*c))
            .collect()
    }

    pub fn set<I: UInt>(&mut self, val: I) {
        self.next
            .as_mut()
            .expect("next should not be none")
            .set(val)
    }

    pub fn get<I: UInt + Default>(&self) -> I {
        self.curr.get()
    }
}

pub struct CxxrtlHandle {
    pub(crate) handle: *mut _cxxrtl_handle,
}

impl CxxrtlHandle {
    pub unsafe fn new(top: *mut _cxxrtl_toplevel) -> Self {
        let handle = cxxrtl_create(top);
        Self { handle }
    }

    pub fn get<const N: u32>(&self, name: &str) -> Option<CxxrtlObject<N>> {
        let cs = CString::new(name).expect("CString::new failed");
        let obj = unsafe { cxxrtl_get(self.handle, cs.as_ptr()) };
        (!obj.is_null()).then_some(CxxrtlObject::new(obj))
    }

    pub fn step(&mut self) {
        unsafe { cxxrtl_step(self.handle) };
    }
}

impl Drop for CxxrtlHandle {
    fn drop(&mut self) {
        unsafe {
            cxxrtl_destroy(self.handle);
        }
    }
}
