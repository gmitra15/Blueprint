#pragma once

#include <SFML/Graphics.hpp>

class TextureLoader {
private:

    std::map<std::string, sf::Texture*> textures;

    static TextureLoader *instance;

    TextureLoader(){};
    TextureLoader(TextureLoader const&){};

public:

    static TextureLoader *getInstance();
    sf::Texture *getTexture(std::string file);
    sf::Sprite getSprite(std::string file);
};
