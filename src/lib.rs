#![allow(clippy::missing_safety_doc)]
use minify_html::{minify as minify_html, Cfg};
use std::slice;

#[repr(C)]
pub struct MinifyResult {
    len: i32,
    ptr: *const u8,
}

#[no_mangle]
pub unsafe extern "C" fn minify(ptr: *const u8, len: i32) -> MinifyResult {
    let result = minify_html(
        slice::from_raw_parts(ptr, len as usize),
        &Cfg::spec_compliant(),
    )
    .leak();
    MinifyResult {
        len: result.len() as i32,
        ptr: result.as_ptr(),
    }
}
