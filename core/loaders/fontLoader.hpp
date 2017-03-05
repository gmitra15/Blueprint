#pragma once

#include <SFML/Graphics.hpp>

class FontLoader {
private:

    std::map<std::string, sf::Font*> fonts;

    static FontLoader *instance;

    FontLoader(){};
    FontLoader(FontLoader const&){};

public:

    static FontLoader *getInstance();
    sf::Font *getFont(std::string file);
};
