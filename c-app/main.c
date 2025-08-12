#include <stdio.h>
#include <stdint.h>

#include "rust.h"

int main() {
    print_from_lib_1((uint8_t*) "Hello, world!!!!\n", 17);
    return 0;
}
