#include "loaders/fontLoader.hpp"
#ifdef _WIN32
#else
//#include "ResourcePath.hpp"
#endif

FontLoader *FontLoader::instance = NULL;

FontLoader *FontLoader::getInstance() {
    if (!instance) {
        instance = new FontLoader();
    }
    return instance;
}

sf::Font *FontLoader::getFont(std::string file) {
    sf::Font *font = fonts[file];

    if (font == NULL) {
        font = new sf::Font();
        font->loadFromFile("fonts/"+file);
        fonts[file] = font;
    }

    return font;
}
