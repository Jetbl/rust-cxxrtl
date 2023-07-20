use std::convert::TryFrom;

pub trait AsBool {
    fn as_bool(&self) -> bool;
}

macro_rules! impl_as_bool {
    ($($typ:ty)+) => {
        $(
          impl AsBool for $typ {
            fn as_bool(&self) -> bool{
                    match *self {
                        0 => false,
                        1 => true,
                        v => panic!("Unsuported value {}", v),
                    }
                }
          }
        )+
    };
}

impl_as_bool! {u8 u16 u32}

pub trait UInt {
    const BITS: u32;

    fn set_chunk(&mut self, chunk: u32, val: u32);
    fn get_chunk(&self, chunk: u32) -> u32;
}

impl UInt for bool {
    const BITS: u32 = 1;

    fn set_chunk(&mut self, chunk: u32, val: u32) {
        debug_assert!(chunk == 0);
        debug_assert!(val == 0 || val == 1);
        *self = val == 1;
    }

    fn get_chunk(&self, chunk: u32) -> u32 {
        debug_assert!(chunk == 0);
        *self as u32
    }
}

impl UInt for u8 {
    const BITS: u32 = u8::BITS;

    fn set_chunk(&mut self, chunk: u32, val: u32) {
        debug_assert!(chunk == 0);
        *self = u8::try_from(val).unwrap()
    }

    fn get_chunk(&self, chunk: u32) -> u32 {
        debug_assert!(chunk == 0);
        *self as u32
    }
}

impl UInt for u16 {
    const BITS: u32 = u16::BITS;

    fn set_chunk(&mut self, chunk: u32, val: u32) {
        debug_assert!(chunk == 0);
        *self = u16::try_from(val).unwrap()
    }

    fn get_chunk(&self, chunk: u32) -> u32 {
        debug_assert!(chunk == 0);
        *self as u32
    }
}

impl UInt for u32 {
    const BITS: u32 = u32::BITS;

    fn set_chunk(&mut self, chunk: u32, val: u32) {
        debug_assert!(chunk == 0);
        *self = val;
    }

    fn get_chunk(&self, chunk: u32) -> u32 {
        debug_assert!(chunk == 0);
        *self
    }
}
// impl UInt for u64 {}
// impl UInt for u128 {}
