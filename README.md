## Test linking multiple static Rust dependencies to a single C application

### LTO Enabled
```
❯ ./build.sh release-lto
~/w/multiple-rust-lib-test/rust-lib-1 ~/w/multiple-rust-lib-test
     Removed 20 files, 40.8MiB total
   Compiling rust-lib-1 v0.1.0 (/Users/vclarksa/w/multiple-rust-lib-test/rust-lib-1)
    Finished `release` profile [optimized] target(s) in 0.11s
   Compiling rust-lib-1 v0.1.0 (/Users/vclarksa/w/multiple-rust-lib-test/rust-lib-1)
    Finished `release-lto` profile [optimized] target(s) in 1.28s
~/w/multiple-rust-lib-test
~/w/multiple-rust-lib-test/rust-lib-2 ~/w/multiple-rust-lib-test
     Removed 20 files, 40.8MiB total
   Compiling rust-lib-2 v0.1.0 (/Users/vclarksa/w/multiple-rust-lib-test/rust-lib-2)
    Finished `release` profile [optimized] target(s) in 0.10s
   Compiling rust-lib-2 v0.1.0 (/Users/vclarksa/w/multiple-rust-lib-test/rust-lib-2)
    Finished `release-lto` profile [optimized] target(s) in 1.28s
~/w/multiple-rust-lib-test
~/w/multiple-rust-lib-test/c-app ~/w/multiple-rust-lib-test
-- The C compiler identification is AppleClang 17.0.0.17000013
-- The CXX compiler identification is AppleClang 17.0.0.17000013
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /usr/bin/cc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /usr/bin/c++ - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- linking rust_lib_1 from /Users/vclarksa/w/multiple-rust-lib-test/c-app/../rust-lib-1/target/release-lto
-- linking rust_lib_2 from /Users/vclarksa/w/multiple-rust-lib-test/c-app/../rust-lib-2/target/release-lto
-- Configuring done (0.8s)
-- Generating done (0.0s)
-- Build files have been written to: /Users/vclarksa/w/multiple-rust-lib-test/c-app/build
[ 50%] Building C object CMakeFiles/hello_world.dir/main.c.o
[100%] Linking C executable hello_world
duplicate symbol 'std::panicking::EMPTY_PANIC::h2876679403c3e8d4' in:
    /Users/vclarksa/w/multiple-rust-lib-test/rust-lib-1/target/release-lto/librust_lib_1.a[2](rust_lib_1-3caace4476186657.rust_lib_1.44fdf01974a1bf1d-cgu.0.rcgu.o)
    /Users/vclarksa/w/multiple-rust-lib-test/rust-lib-2/target/release-lto/librust_lib_2.a[2](rust_lib_2-43121a60472c2541.rust_lib_2.2bc5365de1960803-cgu.0.rcgu.o)
duplicate symbol '_rust_eh_personality' in:
    /Users/vclarksa/w/multiple-rust-lib-test/rust-lib-1/target/release-lto/librust_lib_1.a[2](rust_lib_1-3caace4476186657.rust_lib_1.44fdf01974a1bf1d-cgu.0.rcgu.o)
    /Users/vclarksa/w/multiple-rust-lib-test/rust-lib-2/target/release-lto/librust_lib_2.a[2](rust_lib_2-43121a60472c2541.rust_lib_2.2bc5365de1960803-cgu.0.rcgu.o)
ld: 2 duplicate symbols
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make[2]: *** [hello_world] Error 1
make[1]: *** [CMakeFiles/hello_world.dir/all] Error 2
make: *** [all] Error 2
```

### LTO Disabled
```
❯ ./build.sh release
~/w/multiple-rust-lib-test/rust-lib-1 ~/w/multiple-rust-lib-test
     Removed 20 files, 40.8MiB total
   Compiling rust-lib-1 v0.1.0 (/Users/vclarksa/w/multiple-rust-lib-test/rust-lib-1)
    Finished `release` profile [optimized] target(s) in 0.11s
   Compiling rust-lib-1 v0.1.0 (/Users/vclarksa/w/multiple-rust-lib-test/rust-lib-1)
    Finished `release-lto` profile [optimized] target(s) in 1.28s
~/w/multiple-rust-lib-test
~/w/multiple-rust-lib-test/rust-lib-2 ~/w/multiple-rust-lib-test
     Removed 20 files, 40.8MiB total
   Compiling rust-lib-2 v0.1.0 (/Users/vclarksa/w/multiple-rust-lib-test/rust-lib-2)
    Finished `release` profile [optimized] target(s) in 0.10s
   Compiling rust-lib-2 v0.1.0 (/Users/vclarksa/w/multiple-rust-lib-test/rust-lib-2)
    Finished `release-lto` profile [optimized] target(s) in 1.31s
~/w/multiple-rust-lib-test
~/w/multiple-rust-lib-test/c-app ~/w/multiple-rust-lib-test
-- The C compiler identification is AppleClang 17.0.0.17000013
-- The CXX compiler identification is AppleClang 17.0.0.17000013
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /usr/bin/cc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /usr/bin/c++ - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- linking rust_lib_1 from /Users/vclarksa/w/multiple-rust-lib-test/c-app/../rust-lib-1/target/release
-- linking rust_lib_2 from /Users/vclarksa/w/multiple-rust-lib-test/c-app/../rust-lib-2/target/release
-- Configuring done (0.8s)
-- Generating done (0.0s)
-- Build files have been written to: /Users/vclarksa/w/multiple-rust-lib-test/c-app/build
[ 50%] Building C object CMakeFiles/hello_world.dir/main.c.o
[100%] Linking C executable hello_world
[100%] Built target hello_world
Hello, world!!!!
Hello again, world!
~/w/multiple-rust-lib-test

```
