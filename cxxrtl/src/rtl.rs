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

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
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

pub struct CxxrtlSignal<const N: u32> {
    curr: Value<N>,
    next: Option<Value<N>>,
}

impl<const N: u32> CxxrtlSignal<N> {
    pub fn set<I: UInt>(&mut self, val: I) {
        if let Some(next) = &mut self.next {
            next.set(val);
        }
    }

    pub fn get<I: UInt + Default>(&self) -> I {
        self.curr.get()
    }
}

pub struct CxxrtlMemory<const N: u32> {
    curr: Value<N>,
}

impl<const N: u32> CxxrtlMemory<N> {
    pub fn get<I: UInt + Default>(&self) -> I {
        self.curr.get()
    }
}

#[derive(Debug)]
pub struct CxxrtlObject {
    obj: *mut cxxrtl_object,
    pub flags: Vec<CxxrtlFlag>,
    pub r#type: CxxrtlType,
    pub width: u64,
    pub lsb: u64,
}

impl CxxrtlObject {
    pub fn new(obj: *mut cxxrtl_object) -> Self {
        let width = unsafe { (*obj).width };
        let r#type = unsafe { std::mem::transmute::<u32, CxxrtlType>((*obj).type_) };
        let flags = Self::flags(unsafe { (*obj).flags });
        let lsb = unsafe { (*obj).lsb_at };

        Self {
            obj,
            flags,
            r#type,
            lsb,
            width,
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

    fn values<const N: u32>(&self) -> (Value<N>, Option<Value<N>>) {
        let curr = unsafe { Value::new((*self.obj).curr) };
        let next = (unsafe { *self.obj }).next;
        let next = (!next.is_null()).then_some(unsafe { Value::new(next) });
        (curr, next)
    }

    pub fn signal<const N: u32>(&self) -> CxxrtlSignal<N> {
        assert!(
            matches!(self.r#type, CxxrtlType::Value) || matches!(self.r#type, CxxrtlType::Wire)
        );
        let (curr, next) = self.values();
        CxxrtlSignal { curr, next }
    }

    pub fn memory<const N: u32>(&self) -> CxxrtlMemory<N> {
        assert!(matches!(self.r#type, CxxrtlType::Memory));
        let (curr, _) = self.values();
        CxxrtlMemory { curr }
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

    pub fn get(&self, name: &str) -> Option<CxxrtlObject> {
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
