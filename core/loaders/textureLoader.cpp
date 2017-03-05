#include "loaders/textureLoader.hpp"

TextureLoader *TextureLoader::instance = NULL;

TextureLoader *TextureLoader::getInstance() {
    if (!instance) {
        instance = new TextureLoader();
    }
    return instance;
}

sf::Texture *TextureLoader::getTexture(std::string file) {
    sf::Texture *tex = textures[file];

    if (tex == NULL) {
        tex = new sf::Texture();
        tex->loadFromFile("imgs/"+file);
        textures[file] = tex;
    }

    return tex;
}

sf::Sprite TextureLoader::getSprite(std::string file) {
    sf::Sprite sprite;
    sprite.setTexture(*getTexture(file));
    return sprite;
}
