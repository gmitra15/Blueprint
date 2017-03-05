#include "Wren++.h"

int randomGen(int max) {
    return rand() % max;
}

void createRandomBindings() {
    wrenpp::beginModule("systems/random")
        .beginClass("Random")
            .bindFunction<decltype(&randomGen), randomGen>(true, "int(_)")
        .endClass()
    .endModule();
}