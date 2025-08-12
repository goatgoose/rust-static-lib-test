## Test linking multiple static Rust dependencies to a single C application

### LTO Enabled
```
[ 50%] Building C object CMakeFiles/hello_world.dir/main.c.o
[100%] Linking C executable hello_world
duplicate symbol 'std::panicking::EMPTY_PANIC::h2876679403c3e8d4' in:
    /Users/vclarksa/w/multiple-rust-lib-test/rust-lib-2/target/release-lto/librust_lib_2.a[2](rust_lib_2-43121a60472c2541.rust_lib_2.2bc5365de1960803-cgu.0.rcgu.o)
    /Users/vclarksa/w/multiple-rust-lib-test/rust-lib-1/target/release-lto/librust_lib_1.a[2](rust_lib_1-3caace4476186657.rust_lib_1.44fdf01974a1bf1d-cgu.0.rcgu.o)
duplicate symbol '_rust_eh_personality' in:
    /Users/vclarksa/w/multiple-rust-lib-test/rust-lib-2/target/release-lto/librust_lib_2.a[2](rust_lib_2-43121a60472c2541.rust_lib_2.2bc5365de1960803-cgu.0.rcgu.o)
    /Users/vclarksa/w/multiple-rust-lib-test/rust-lib-1/target/release-lto/librust_lib_1.a[2](rust_lib_1-3caace4476186657.rust_lib_1.44fdf01974a1bf1d-cgu.0.rcgu.o)
ld: 2 duplicate symbols
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make[2]: *** [hello_world] Error 1
make[1]: *** [CMakeFiles/hello_world.dir/all] Error 2
make: *** [all] Error 2
```

### LTO Disabled
```
[ 50%] Building C object CMakeFiles/hello_world.dir/main.c.o
[100%] Linking C executable hello_world
[100%] Built target hello_world
Hello, world!!!!
Hello again, world!
```
