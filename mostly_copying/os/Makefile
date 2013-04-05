all:	os-test

CFLAGS = -g3 -O2 -arch x86_64 -std=c99

os-darwin-x64.o: os.h os-darwin-x64.c
	$(CC) -c $(CFLAGS) -o os-darwin-x64.o os-darwin-x64.c

os-test.o: os.h os-test.c
	$(CC) -c $(CFLAGS) -o os-test.o os-test.c

os-test: os-test.o os-darwin-x64.o
	$(CC) $(CFLAGS) -o os-test os-test.o os-darwin-x64.o

clean:
	rm -rf *.o
	rm -rf os-test
