#include "engine.hpp"

#include "sprite.hpp"
#include "sound.hpp"
#include "input.hpp"
#include "view.hpp"

#include <iostream>

Engine *Engine::engine = nullptr;

Engine *Engine::getInstance() {
    if (engine == nullptr) {
        Engine::createBindings();
        engine = new Engine();
    }

    return engine;
}

void Engine::createBindings() {
    createSpriteBindings();
    createSoundBindings();
    createInputBindings();
    createViewBindings();
}

sf::RenderWindow *Engine::getWindow() {
    return window;
}

void Engine::addRenderObject(sf::Sprite const &sprite, int layer) {
    renderObjects[layer].push_back(sprite);
}

Engine::Engine() :
    update(vm.method("main", "Director", "update(_)")),
    render(vm.method("main", "Director", "render()")) {

    auto width = vm.method("main", "Settings", "width")();
    auto height = vm.method("main", "Settings", "height")();
    auto vsync = vm.method("main", "Settings", "vsync")();
    auto title = vm.method("main", "Settings", "title")();

    dt = 1.0 / vm.method("main", "Settings", "fps")().as<double>();

    window = new sf::RenderWindow(
        sf::VideoMode(width.as<double>(), height.as<double>()),
        title.as<const char*>()
    );
    window->setVerticalSyncEnabled(vsync.as<bool>());
}

void Engine::run() {
    sf::Clock timer;

    double acc = 0;

    bool redraw = false;
    bool quit = false;

    while (!quit) {
        sf::Event event;
        
        while (window->pollEvent(event)) {
            if (event.type == sf::Event::Closed) {
                quit = true;
                break;
            }
        }

        acc += timer.restart().asSeconds();
        acc = std::min(acc,0.5);

        while (acc >= 0) {
            if (update(dt).as<bool>()) {
                quit = true;
                break;
            }
            redraw = true;
            acc -= dt;
        }

        if (redraw) {
            renderObjects.clear();
            render();

            window->clear();
            for (auto layer : renderObjects) {
                for (auto ro : layer.second) {
                    window->draw(ro);
                }
            }
            window->display();
        }
    }
}
