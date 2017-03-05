#include "Wren++.h"

#include "engine.hpp"

#include "view.hpp"

View::View(float x, float y, float w, float h) {
    _view.setCenter(sf::Vector2f(x, y));
    _view.setSize(sf::Vector2f(w, h));
}

void View::setPosition(float x, float y) {
    _view.setCenter(x, y);
}

void View::activate() {
    Engine::getInstance()->getWindow()->setView(_view);
}

void createViewBindings() {
    wrenpp::beginModule( "systems/view" )
        .bindClass< View, float, float, float, float >( "View" )
            .bindMethod< decltype(&View::activate), &View::activate >(false, "activate()")
            .bindMethod< decltype(&View::setPosition), &View::setPosition >(false, "setPosition(_,_)")
        .endClass()
    .endModule();
}