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

    line = sf::VertexArray(sf::Lines, iter * 2);

    end = sf::VertexArray(sf::Lines, 4);
    end[0].position = sf::Vector2f(std::cos(ang0) * rad0 + x, std::sin(ang0) * rad0 + y);
    end[1].position = sf::Vector2f(std::cos(ang0) * rad1 + x, std::sin(ang0) * rad1 + y);
    end[2].position = sf::Vector2f(std::cos(ang1) * rad0 + x, std::sin(ang1) * rad0 + y);
    end[3].position = sf::Vector2f(std::cos(ang1) * rad1 + x, std::sin(ang1) * rad1 + y);

    end[0].color = sf::Color(0, 0, 0);
    end[1].color = sf::Color(0, 0, 0);
    end[2].color = sf::Color(0, 0, 0);
    end[3].color = sf::Color(0, 0, 0);

    float sections[int(iter + 1)];

    for (int i=0; i<iter+1; i++) {
        sections[i] = ang0 + dif * i;
    }

    for (int i=0; i<iter; i++) {
        line[i * 2].position = sf::Vector2f(std::cos(sections[i])*rad1 + x, std::sin(sections[i])*rad1 + y);
        line[i * 2 + 1].position = sf::Vector2f(std::cos(sections[i]+1)*rad1 + x, std::sin(sections[i]+1)*rad1 + y);

        line[i * 2].color = sf::Color(0, 0, 0);
        line[i * 2 + 1].color = sf::Color(0, 0, 0);

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
    // Engine::getInstance()->getWindow()->draw(line);
    // Engine::getInstance()->getWindow()->draw(end);
}

void createCircleBindings() {
    wrenpp::beginModule( "systems/circle" )
        .bindClass< Circle, float, float, float, float, int, int, int >( "Circle" )
            .bindMethod< decltype(&Circle::render), &Circle::render >(false, "render()")
        .endClass()
    .endModule();
}
