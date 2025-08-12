#!/bin/bash

set -e

pushd rust-lib-1
cargo clean
cargo build --profile release
cargo build --profile release-lto
popd

pushd rust-lib-2
cargo clean
cargo build --profile release
cargo build --profile release-lto
popd

RELEASE_TARGET="release-lto"
#RELEASE_TARGET="release"

pushd c-app
rm -rf build
cmake . -Bbuild -DRELEASE_TARGET="${RELEASE_TARGET}"
cmake --build build -j $(sysctl -n hw.ncpu)
./build/hello_world
popd

