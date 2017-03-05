#include <cmath>

#include "Wren++.h"

#include "engine.hpp"
#include "loaders/textureLoader.hpp"
#include "sprite.hpp"

#include <iostream>

Sprite::Sprite(std::string file) :
        framesPerRow(0),
        frameWidth(0),
        frameHeight(0) {
    _sprite = TextureLoader::getInstance()->getSprite(file);

    _sprite.setOrigin(_sprite.getTexture()->getSize().x/2,
                      _sprite.getTexture()->getSize().y/2);
}

void Sprite::setLayer(int l) {
    layer = l;
}

void Sprite::setFrameSize(int w, int h) {
    frameWidth = w;
    frameHeight = h;

    framesPerRow = _sprite.getTexture()->getSize().x / frameWidth;

    _sprite.setOrigin(w/2,h/2);
}

void Sprite::setFrame(int f) {
    int x = f % framesPerRow * frameWidth;
    int y = f / framesPerRow * frameHeight;

    _sprite.setTextureRect(sf::IntRect(x,y,frameWidth,frameHeight));
}

void Sprite::setPosition(float x, float y) {
    _sprite.setPosition(x,y);
}

void Sprite::setAngle(double angle) {
    _sprite.setRotation(angle * 180 / 3.14159265);
}

void Sprite::setDirection(int direction) {
    _sprite.setScale(direction,1);
}

void Sprite::render() const {
    Engine::getInstance()->addRenderObject(_sprite, layer);
}

void createSpriteBindings() {
    wrenpp::beginModule( "systems/sprite" )
        .bindClass< Sprite, std::string >( "Sprite" )
            .bindMethod< decltype(&Sprite::setLayer), &Sprite::setLayer >(false, "layer=(_)")
            .bindMethod< decltype(&Sprite::setFrameSize), &Sprite::setFrameSize >(false, "setFrameSize(_,_)")
            .bindMethod< decltype(&Sprite::setFrame), &Sprite::setFrame >(false, "frame=(_)")
            .bindMethod< decltype(&Sprite::setAngle), &Sprite::setAngle >(false, "angle=(_)")
            .bindMethod< decltype(&Sprite::setDirection), &Sprite::setDirection >(false, "direction=(_)")
            .bindMethod< decltype(&Sprite::setPosition), &Sprite::setPosition >(false, "setPosition(_,_)")
            .bindMethod< decltype(&Sprite::render), &Sprite::render >(false, "render()")
        .endClass()
    .endModule();
}
