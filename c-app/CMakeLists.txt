cmake_minimum_required(VERSION 3.10)

# Set the project name and version
project(HelloWorld VERSION 1.0)

option(PREFIX_RUST_SYMBOLS "prefix the symbols of rust_lib_2" OFF)

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

if(PREFIX_RUST_SYMBOLS)
    link_directories("${CMAKE_CURRENT_BINARY_DIR}")
else()
    link_directories("${RUST_LIB_2_DIR}")
endif()

# Add the executable
add_executable(hello_world main.c rust.h)

target_link_libraries(hello_world PUBLIC "${RUST_LIB_1_NAME}")

if(PREFIX_RUST_SYMBOLS)
    # from https://github.com/aws/s2n-tls/blob/83dcc99c93a17fcb8f4aeffaf543d962fa672cf7/CMakeLists.txt#L410
    add_custom_command(
        OUTPUT rust_lib_2.symbols
        COMMAND
          cp "${RUST_LIB_2_DIR}/librust_lib_2.a" libprefixed_rust_lib_2.a &&
          # dump all of the symbols and prefix them with `my_prefix$`
          bash -c "nm libprefixed_rust_lib_2.a | awk '/ [A-Z] /{if ($3) print $3\" my_prefix$\"$3}' | sort | uniq > rust_lib_2.symbols" &&
          # redefine the rust_lib_2 libary symbols
          objcopy --redefine-syms rust_lib_2.symbols libprefixed_rust_lib_2.a &&
          rm -rf prefixed_rust_lib_2 &&
          mkdir prefixed_rust_lib_2 &&
          cd prefixed_rust_lib_2 &&
          # extract rust_lib_2 objects from the archive
          ar x ../libprefixed_rust_lib_2.a &&
          # rename all of the object files so we don't have any object name collisions
          bash -c "find . -name '*.o' -type f -print0 | xargs -0 -n1 -- basename | xargs -I{} mv {} my_prefix__{}"
        VERBATIM
    )

    add_custom_target(rust_lib_2 ALL
      DEPENDS rust_lib_2.symbols
    )
    add_dependencies(hello_world rust_lib_2)

    # rewrite references so use of internal functions will link correctly
    add_custom_command(
        TARGET hello_world PRE_LINK
        COMMAND
          find "${CMAKE_CURRENT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/hello_world.dir" -name '*.c.o' -exec objcopy --redefine-syms rust_lib_2.symbols --preserve-dates {} \\\;
    )

    target_link_libraries(hello_world PUBLIC "prefixed_rust_lib_2")
else()
    target_link_libraries(hello_world PUBLIC "${RUST_LIB_2_NAME}")
endif()

target_link_libraries(hello_world PUBLIC pthread dl)
