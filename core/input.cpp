#include "Wren++.h"

#include <SFML/Window.hpp>

#include "engine.hpp"

bool keydown(int key) {
    return sf::Keyboard::isKeyPressed(static_cast<sf::Keyboard::Key>(key));
}

bool buttondown(int button) {
    return sf::Mouse::isButtonPressed(static_cast<sf::Mouse::Button>(button));
}

float locationX() {
    sf::Vector2i local = sf::Mouse::getPosition(*Engine::getInstance()->getWindow());
    sf::Vector2f world = Engine::getInstance()->getWindow()->mapPixelToCoords(local);
    return world.x;
}

float locationY() {
    sf::Vector2i local = sf::Mouse::getPosition(*Engine::getInstance()->getWindow());
    sf::Vector2f world = Engine::getInstance()->getWindow()->mapPixelToCoords(local);
    return world.y;
}

float joystickX(int i) {
    return sf::Joystick::getAxisPosition(i, sf::Joystick::X);
}

float joystickY(int i) {
    return sf::Joystick::getAxisPosition(i, sf::Joystick::Y);
}

float joystickZ(int i) {
    return sf::Joystick::getAxisPosition(i, sf::Joystick::Z);
}

float joystickR(int i) {
    return sf::Joystick::getAxisPosition(i, sf::Joystick::R);
}

bool joystickButton(int i, int button) {
    return sf::Joystick::isButtonPressed(i, button);
}

void createInputBindings() {
    wrenpp::beginModule("systems/input")
        .beginClass("Keyboard")
            .bindFunction<decltype(&keydown), keydown>(true, "keydown(_)")
        .endClass()
        .beginClass("Mouse")
            .bindFunction<decltype(&buttondown), buttondown>(true, "buttondown(_)")
            .bindFunction<decltype(&locationX), locationX>(true, "x")
            .bindFunction<decltype(&locationY), locationY>(true, "y")
        .endClass()
        .beginClass("Joystick")
            .bindFunction<decltype(&joystickX), joystickX>(true, "x(_)")
            .bindFunction<decltype(&joystickY), joystickY>(true, "y(_)")
            .bindFunction<decltype(&joystickZ), joystickZ>(true, "z(_)")
            .bindFunction<decltype(&joystickR), joystickR>(true, "r(_)")
            .bindFunction<decltype(&joystickButton), joystickButton>(true, "buttondown(_,_)")
        .endClass()
    .endModule();
}
