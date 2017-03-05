#pragma once

#include <SFML/Graphics.hpp>

class Circle {
private:
    sf::VertexArray quad;

public:
    Circle(float ang0, float rad0, float ang1, float rad1, int r, int g, int b);

    void render() const;
};

void createCircleBindings();
