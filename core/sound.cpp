#include "Wren++.h"

#include "sound.hpp"
#include "loaders/soundLoader.hpp"

void preloadSound(std::string sound) {
    SoundLoader::getInstance()->loadSound(sound);
}

void playSound(std::string sound) {
    SoundLoader::getInstance()->playSound(sound);
}

void createSoundBindings() {
    wrenpp::beginModule("systems/sound")
        .beginClass("Sound")
            .bindFunction<decltype(&preloadSound), preloadSound>(true, "preloadSound(_)")
            .bindFunction<decltype(&playSound), playSound>(true, "playSound(_)")
        .endClass()
    .endModule();
}
