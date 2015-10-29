extern crate libc;

use libc::{c_double, size_t};
use std::slice;

#[no_mangle]
pub extern fn rust_dot_product(
    array_1_pointer: *const c_double,
    array_2_pointer: *const c_double,
    array_size: size_t) -> c_double {

    let array1 = unsafe {
        assert!(!array_1_pointer.is_null(), "Null pointer exception");

        slice::from_raw_parts(array_1_pointer, array_size as usize)
    };

    let array2 = unsafe {
        assert!(!array_2_pointer.is_null(), "Null pointer exception");

        slice::from_raw_parts(array_2_pointer, array_size as usize)
    };

    dot_product(array1, array2) as libc::c_double
}

fn dot_product(array1: &[f64], array2: &[f64]) -> f64 {
    array1.iter()
        .zip( array2.iter() )
        .fold(0.0, |sum, (e1, e2)| sum + e1*e2)
}

#[cfg(test)]
mod tests {
    use super::dot_product;

    #[test]
    fn a_few_elements() {
        let evens: [f64; 3] = [0.0, 2.0, 4.0];
        let odds: [f64; 3] = [1.0, 3.0, 5.0];

        assert_eq!(26.0, dot_product(&evens, &odds));
    }
}
