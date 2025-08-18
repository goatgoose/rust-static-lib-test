cmake_minimum_required(VERSION 3.10)

# Set the project name and version
project(HelloWorld VERSION 1.0)

# Specify the C standard
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED True)

set(RUST_LIB_1_DIR "${CMAKE_SOURCE_DIR}/../rust-lib-1/target/${RELEASE_TARGET}")
set(RUST_LIB_1_NAME "rust_lib_1")
message(STATUS "linking ${RUST_LIB_1_NAME} from ${RUST_LIB_1_DIR}")

link_directories("${RUST_LIB_1_DIR}")

set(RUST_LIB_2_DIR "${CMAKE_SOURCE_DIR}/../rust-lib-2/target/${RELEASE_TARGET}")
set(RUST_LIB_2_NAME "rust_lib_2")
message(STATUS "linking ${RUST_LIB_2_NAME} from ${RUST_LIB_2_DIR}")

link_directories("${RUST_LIB_2_DIR}")

# Add the executable
add_executable(hello_world main.c rust.h)

target_link_libraries(hello_world PUBLIC "${RUST_LIB_1_NAME}")
target_link_libraries(hello_world PUBLIC "${RUST_LIB_2_NAME}")
target_link_libraries(hello_world PUBLIC pthread dl)
