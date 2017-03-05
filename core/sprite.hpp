#pragma once

#include <SFML/Graphics.hpp>

class Sprite {
private:
    sf::Sprite _sprite;

    int framesPerRow;
    int frameWidth;
    int frameHeight;

    int layer;

public:
    Sprite(std::string file);

    void setLayer(int l);

    void setFrameSize(int w, int h);

    void setFrame(int f);

    void setPosition(float x, float y);

    void setAngle(double angle);

    void setDirection(int i);

    void render() const;
};

void createSpriteBindings();