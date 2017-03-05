#pragma once

#include <SFML/Graphics.hpp>

class Text {
private:
    sf::Text _text;

public:
    Text(std::string file);

    void setString(std::string);
    void setPosition(float x, float y);

    void render() const;
};

void createTextBindings();