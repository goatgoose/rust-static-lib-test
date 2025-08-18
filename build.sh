#!/bin/bash

set -e

if [ "$#" -ne 1 ]; then
  echo "Usage: ./build.sh <release target>"
  exit 1
fi

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

pushd c-app
rm -rf build
cmake3 . -Bbuild -DRELEASE_TARGET="$1"
cmake3 --build build -j $(sysctl -n hw.ncpu)
./build/hello_world
popd

