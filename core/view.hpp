#pragma once

#include <sfml/graphics.hpp>

class View {
    sf::View _view;
public:
    View(float x, float y, float w, float h);

    void activate();
    void setPosition(float x, float y);
};

void createViewBindings();
