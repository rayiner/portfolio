libvfun.so: vfun.h vfun.cpp
	g++ -shared -fPIC vfun.cpp -o libvfun.so

install: libvfun.so
	cp libvfun.so /usr/lib
	cp vfun.h /usr/include

