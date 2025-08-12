#include <stdio.h>
#include <stdint.h>

#include "rust.h"

int main() {
    print_from_lib_1((uint8_t*) "Hello from lib 1!\n", 18);
    print_from_lib_2((uint8_t*) "Hello from lib 2!\n", 18);
    return 0;
}
