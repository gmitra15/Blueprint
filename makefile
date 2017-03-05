CC=gcc
CXX=g++
CFLAGS=-Ivm -g
CXXFLAGS=-std=c++14 -Ivm -Icore -g
LIBS=-lsfml-window -lsfml-graphics -lsfml-system -lsfml-audio
OBJ = core/main.o core/engine.o core/Wren++.o core/sprite.o core/sound.o core/input.o core/view.o core/random.o core/text.o \
	  core/loaders/textureLoader.o core/loaders/soundLoader.o core/loaders/fontLoader.o core/circle.o \
	  vm/wren_vm.o vm/wren_value.o vm/wren_utils.o vm/wren_primitive.o vm/wren_debug.o vm/wren_core.o vm/wren_compiler.o

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

%.o: %.cpp $(DEPS)
	$(CXX) -c -o $@ $< $(CXXFLAGS)

game: $(OBJ)
	$(CXX) -o $@ $^ $(CXXFLAGS) $(LIBS)

clean:
	rm */*.o
