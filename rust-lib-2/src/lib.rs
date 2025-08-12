use std::io::{self, Write};

#[unsafe(no_mangle)]
pub fn print_from_lib_2(bytes: *const u8, len: usize) {
    let bytes = unsafe { std::slice::from_raw_parts(bytes, len) };

    let mut stdout = io::stdout();
    stdout.write_all(bytes).unwrap();
    stdout.flush().unwrap();
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let test_str = "hello world!\n";
        print_from_lib_2(test_str.as_ptr(), test_str.len());
    }
}
