#include <cmath>

#include "Wren++.h"

#include "engine.hpp"
#include "loaders/fontLoader.hpp"
#include "text.hpp"

#include <iostream>

Text::Text(std::string file) {
    _text.setFont(*FontLoader::getInstance()->getFont(file));
    _text.setColor(sf::Color::White);
    _text.setCharacterSize(32);
}

void Text::setString(std::string s) {
    _text.setString(s);
}

void Text::setPosition(float x, float y) {
    _text.setPosition(x,y);
}

void Text::render() const {
    Engine::getInstance()->getWindow()->draw(_text);
}

void createTextBindings() {
    wrenpp::beginModule( "systems/sprite" )
        .bindClass< Text, std::string >( "Text" )
            .bindMethod< decltype(&Text::setString), &Text::setString >(false, "setString(_)")
            .bindMethod< decltype(&Text::setPosition), &Text::setPosition >(false, "setPosition(_,_)")
            .bindMethod< decltype(&Text::render), &Text::render >(false, "render()")
        .endClass()
    .endModule();
}
