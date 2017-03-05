#include "loaders/soundLoader.hpp"

SoundLoader *SoundLoader::instance = NULL;

SoundLoader *SoundLoader::getInstance() {
    if (!instance) {
        instance = new SoundLoader();
    }
    return instance;
}

sf::SoundBuffer *SoundLoader::loadSound(std::string file) {
    sf::SoundBuffer *sample = samples[file];

    if (sample == NULL) {
        sample = new sf::SoundBuffer();
        sample->loadFromFile("sounds/"+file);
        samples[file] = sample;
    }

    return sample;
}

void SoundLoader::playSound(std::string file) {
    for (auto it = sounds.begin(); it != sounds.end(); ++it) {
        sf::Sound &sound = **it;

        if (sound.getStatus() == sf::Sound::Stopped) {
            delete *it;
            sounds.erase(it);
            --it;
        }
    }

    sf::SoundBuffer *sample = loadSound(file);

    sf::Sound *sound = new sf::Sound();
    sound->setBuffer(*sample);
    sound->play();

    sounds.emplace_back(sound);
}
