#pragma once

#include <map>

#include <SFML/Audio.hpp>

class SoundLoader {
private:

    std::map<std::string, sf::SoundBuffer*> samples;
    std::vector<sf::Sound*> sounds;

    static SoundLoader *instance;

    SoundLoader(){};
    SoundLoader(SoundLoader const&){};

public:

    static SoundLoader *getInstance();

    sf::SoundBuffer *loadSound(std::string file);
    void playSound(std::string file);
};
