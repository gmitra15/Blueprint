#include <cmath>

#include "Wren++.h"

#include "engine.hpp"
#include "loaders/textureLoader.hpp"
#include "circle.hpp"

#include <iostream>

Circle::Circle(float ang0, float rad0, float ang1, float rad1, int r, int g, int b) {
    float iter = 100;
    float dif = (ang1 - ang0) / iter;
    float x = 1920/2;
    float y = 1080/2;

    quad = sf::VertexArray(sf::Quads, iter * 4);

    float sections[int(iter + 1)];

    for (int i=0; i<iter+1; i++) {
        sections[i] = ang0 + dif * i;
    }

    for (int i=0; i<iter; i++) {
        quad[i * 4].position = sf::Vector2f(std::cos(sections[i])*rad0 + x,
                                        std::sin(sections[i])*rad0 + y);

        quad[i * 4 + 1].position = sf::Vector2f(std::cos(sections[i])*rad1 + x,
                                        std::sin(sections[i])*rad1 + y);

        quad[i * 4 + 2].position = sf::Vector2f(std::cos(sections[i+1])*rad1 + x,
                                        std::sin(sections[i+1])*rad1 + y);

        quad[i * 4 + 3].position = sf::Vector2f(std::cos(sections[i+1])*rad0 + x,
                                        std::sin(sections[i+1])*rad0 + y);

        quad[i * 4].color = sf::Color(r, g, b);
        quad[i * 4 + 1].color = sf::Color(r, g, b);
        quad[i * 4 + 2].color = sf::Color(r, g, b);
        quad[i * 4 + 3].color = sf::Color(r, g, b);
    }
}

void Circle::render() const {
    Engine::getInstance()->getWindow()->draw(quad);
}

void createCircleBindings() {
    wrenpp::beginModule( "systems/circle" )
        .bindClass< Circle, float, float, float, float, int, int, int >( "Circle" )
            .bindMethod< decltype(&Circle::render), &Circle::render >(false, "render()")
        .endClass()
    .endModule();
}
