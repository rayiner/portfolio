CXX = g++
CXXFLAGS = -O3 -g3 -arch x86_64 -std=c++98 -Wall

all:	vitamin

machine.o:	machine.cpp machine.h
	$(CXX) $(CXXFLAGS) -c -o machine.o machine.cpp

loader.o:	loader.cpp machine.h
	$(CXX) $(CXXFLAGS) -c -o loader.o loader.cpp

interpreter.o:	interpreter.cpp machine.h
	$(CXX) $(CXXFLAGS) -c -o interpreter.o interpreter.cpp

primitives.o:	primitives.cpp machine.h
	$(CXX) $(CXXFLAGS) -c -o primitives.o primitives.cpp

display.o:	display.cpp machine.h
	$(CXX) $(CXXFLAGS) -c -o display.o display.cpp

vitamin:	primitives.o display.o interpreter.o loader.o machine.o	machine.h
	$(CXX) $(CXXFLAGS) -o vitamin machine.o loader.o interpreter.o  display.o primitives.o

clean:
	rm -rf *.o vitamin
