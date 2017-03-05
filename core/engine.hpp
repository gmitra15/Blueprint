#pragma once

#include "Wren++.h"

#include <sfml/graphics.hpp>

class Engine {
private:
    Engine();
    static Engine *engine;

    wrenpp::VM vm;
    wrenpp::Method update, render;

    sf::RenderWindow *window;

    std::map<int, std::vector<sf::Sprite> > renderObjects;

    double dt;

public:
    static void createBindings();
    static Engine *getInstance();

    sf::RenderWindow *getWindow();
    void addRenderObject(sf::Sprite const &Sprite, int layer);

    void run();
};