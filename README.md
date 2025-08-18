## Test linking multiple static Rust dependencies to a single C application

### LTO Disabled
There are no symbol conflicts when LTO is disabled:
```
dev-dsk-vclarksa-1d-9a51ba9d % ./build.sh release no
~/rust-static-lib-test/rust-lib-1 ~/rust-static-lib-test
     Removed 20 files, 50.5MiB total
   Compiling rust-lib-1 v0.1.0 (/local/home/vclarksa/rust-static-lib-test/rust-lib-1)
    Finished `release` profile [optimized] target(s) in 0.11s
   Compiling rust-lib-1 v0.1.0 (/local/home/vclarksa/rust-static-lib-test/rust-lib-1)
    Finished `release-lto` profile [optimized] target(s) in 2.35s
~/rust-static-lib-test
~/rust-static-lib-test/rust-lib-2 ~/rust-static-lib-test
     Removed 20 files, 50.5MiB total
   Compiling rust-lib-2 v0.1.0 (/local/home/vclarksa/rust-static-lib-test/rust-lib-2)
    Finished `release` profile [optimized] target(s) in 0.11s
   Compiling rust-lib-2 v0.1.0 (/local/home/vclarksa/rust-static-lib-test/rust-lib-2)
    Finished `release-lto` profile [optimized] target(s) in 2.33s
~/rust-static-lib-test
~/rust-static-lib-test/c-app ~/rust-static-lib-test
-- The C compiler identification is GNU 7.3.1
-- The CXX compiler identification is GNU 7.3.1
-- Check for working C compiler: /usr/bin/cc
-- Check for working C compiler: /usr/bin/cc - works
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Detecting C compile features
-- Detecting C compile features - done
-- Check for working CXX compiler: /usr/bin/c++
-- Check for working CXX compiler: /usr/bin/c++ - works
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- linking rust_lib_1 from /home/vclarksa/rust-static-lib-test/c-app/../rust-lib-1/target/release
-- linking rust_lib_2 from /home/vclarksa/rust-static-lib-test/c-app/../rust-lib-2/target/release
-- Configuring done
-- Generating done
-- Build files have been written to: /home/vclarksa/rust-static-lib-test/c-app/build
sysctl: cannot stat /proc/sys/hw/ncpu: No such file or directory
Scanning dependencies of target hello_world
[ 50%] Building C object CMakeFiles/hello_world.dir/main.c.o
[100%] Linking C executable hello_world
[100%] Built target hello_world
Hello from lib 1!
Hello from lib 2!
~/rust-static-lib-test
```

### LTO Enabled
There are some symbol conflicts when LTO is enabled:
```
dev-dsk-vclarksa-1d-9a51ba9d % ./build.sh release-lto no
~/rust-static-lib-test/rust-lib-1 ~/rust-static-lib-test
     Removed 20 files, 50.5MiB total
   Compiling rust-lib-1 v0.1.0 (/local/home/vclarksa/rust-static-lib-test/rust-lib-1)
    Finished `release` profile [optimized] target(s) in 0.11s
   Compiling rust-lib-1 v0.1.0 (/local/home/vclarksa/rust-static-lib-test/rust-lib-1)
    Finished `release-lto` profile [optimized] target(s) in 2.33s
~/rust-static-lib-test
~/rust-static-lib-test/rust-lib-2 ~/rust-static-lib-test
     Removed 20 files, 50.5MiB total
   Compiling rust-lib-2 v0.1.0 (/local/home/vclarksa/rust-static-lib-test/rust-lib-2)
    Finished `release` profile [optimized] target(s) in 0.11s
   Compiling rust-lib-2 v0.1.0 (/local/home/vclarksa/rust-static-lib-test/rust-lib-2)
    Finished `release-lto` profile [optimized] target(s) in 2.36s
~/rust-static-lib-test
~/rust-static-lib-test/c-app ~/rust-static-lib-test
-- The C compiler identification is GNU 7.3.1
-- The CXX compiler identification is GNU 7.3.1
-- Check for working C compiler: /usr/bin/cc
-- Check for working C compiler: /usr/bin/cc - works
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Detecting C compile features
-- Detecting C compile features - done
-- Check for working CXX compiler: /usr/bin/c++
-- Check for working CXX compiler: /usr/bin/c++ - works
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- linking rust_lib_1 from /home/vclarksa/rust-static-lib-test/c-app/../rust-lib-1/target/release-lto
-- linking rust_lib_2 from /home/vclarksa/rust-static-lib-test/c-app/../rust-lib-2/target/release-lto
-- Configuring done
-- Generating done
-- Build files have been written to: /home/vclarksa/rust-static-lib-test/c-app/build
sysctl: cannot stat /proc/sys/hw/ncpu: No such file or directory
Scanning dependencies of target hello_world
[ 50%] Building C object CMakeFiles/hello_world.dir/main.c.o
[100%] Linking C executable hello_world
/home/vclarksa/rust-static-lib-test/c-app/../rust-lib-2/target/release-lto/librust_lib_2.a(rust_lib_2-8fc1fa5e637e20a5.rust_lib_2.d74dec2c771d0cc4-cgu.0.rcgu.o): In function `rust_eh_personality':
/rustc/4d91de4e48198da2e33413efdcd9cd2cc0c46688/library/std/src/sys/personality/gcc.rs:294: multiple definition of `rust_eh_personality'
/home/vclarksa/rust-static-lib-test/c-app/../rust-lib-1/target/release-lto/librust_lib_1.a(rust_lib_1-9e36f42e4c2cfc24.rust_lib_1.813d6725557e6605-cgu.0.rcgu.o):/rustc/4d91de4e48198da2e33413efdcd9cd2cc0c46688/library/std/src/sys/personality/gcc.rs:294: first defined here
/home/vclarksa/rust-static-lib-test/c-app/../rust-lib-2/target/release-lto/librust_lib_2.a(rust_lib_2-8fc1fa5e637e20a5.rust_lib_2.d74dec2c771d0cc4-cgu.0.rcgu.o):(.data.rel.ro._ZN3std9panicking11EMPTY_PANIC17h2ee581f5a87150daE+0x0): multiple definition of `std::panicking::EMPTY_PANIC'
/home/vclarksa/rust-static-lib-test/c-app/../rust-lib-1/target/release-lto/librust_lib_1.a(rust_lib_1-9e36f42e4c2cfc24.rust_lib_1.813d6725557e6605-cgu.0.rcgu.o):(.data.rel.ro._ZN3std9panicking11EMPTY_PANIC17h2ee581f5a87150daE+0x0): first defined here
/home/vclarksa/rust-static-lib-test/c-app/../rust-lib-2/target/release-lto/librust_lib_2.a(rust_lib_2-8fc1fa5e637e20a5.rust_lib_2.d74dec2c771d0cc4-cgu.0.rcgu.o):(.init_array.00099+0x0): multiple definition of `std::sys::pal::unix::args::imp::ARGV_INIT_ARRAY'
/home/vclarksa/rust-static-lib-test/c-app/../rust-lib-1/target/release-lto/librust_lib_1.a(rust_lib_1-9e36f42e4c2cfc24.rust_lib_1.813d6725557e6605-cgu.0.rcgu.o):(.init_array.00099+0x0): first defined here
collect2: error: ld returned 1 exit status
gmake[2]: *** [hello_world] Error 1
gmake[1]: *** [CMakeFiles/hello_world.dir/all] Error 2
gmake: *** [all] Error 2
```

### LTO Enabled with symbol prefixing
There are no symbol conflicts when the symbols from one of the Rust libraries are prefixed:
```
(25-08-18 18:58:28) <0> [~/rust-static-lib-test]  
dev-dsk-vclarksa-1d-9a51ba9d % ./build.sh release-lto yes
~/rust-static-lib-test/rust-lib-1 ~/rust-static-lib-test
     Removed 20 files, 50.5MiB total
   Compiling rust-lib-1 v0.1.0 (/local/home/vclarksa/rust-static-lib-test/rust-lib-1)
    Finished `release` profile [optimized] target(s) in 0.11s
   Compiling rust-lib-1 v0.1.0 (/local/home/vclarksa/rust-static-lib-test/rust-lib-1)
    Finished `release-lto` profile [optimized] target(s) in 2.36s
~/rust-static-lib-test
~/rust-static-lib-test/rust-lib-2 ~/rust-static-lib-test
     Removed 20 files, 50.5MiB total
   Compiling rust-lib-2 v0.1.0 (/local/home/vclarksa/rust-static-lib-test/rust-lib-2)
    Finished `release` profile [optimized] target(s) in 0.11s
   Compiling rust-lib-2 v0.1.0 (/local/home/vclarksa/rust-static-lib-test/rust-lib-2)
    Finished `release-lto` profile [optimized] target(s) in 2.34s
~/rust-static-lib-test
~/rust-static-lib-test/c-app ~/rust-static-lib-test
-- The C compiler identification is GNU 7.3.1
-- The CXX compiler identification is GNU 7.3.1
-- Check for working C compiler: /usr/bin/cc
-- Check for working C compiler: /usr/bin/cc - works
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Detecting C compile features
-- Detecting C compile features - done
-- Check for working CXX compiler: /usr/bin/c++
-- Check for working CXX compiler: /usr/bin/c++ - works
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- linking rust_lib_1 from /home/vclarksa/rust-static-lib-test/c-app/../rust-lib-1/target/release-lto
-- linking rust_lib_2 from /home/vclarksa/rust-static-lib-test/c-app/../rust-lib-2/target/release-lto
-- Configuring done
-- Generating done
-- Build files have been written to: /home/vclarksa/rust-static-lib-test/c-app/build
sysctl: cannot stat /proc/sys/hw/ncpu: No such file or directory
Scanning dependencies of target rust_lib_2
[ 33%] Generating rust_lib_2.symbols
[ 33%] Built target rust_lib_2
Scanning dependencies of target hello_world
[ 66%] Building C object CMakeFiles/hello_world.dir/main.c.o
[100%] Linking C executable hello_world
[100%] Built target hello_world
Hello from lib 1!
Hello from lib 2!
~/rust-static-lib-test
```

