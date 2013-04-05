CFLAGS = -O3 -g -arch x86_64 -std=c99 -Wall -pedantic -Wextra \
	 -Wno-unused-parameter -Wno-format

all: gc-test

gc.o: gc.c gc.h gc-internal.h
	$(CC) -c $(CFLAGS) -o gc.o gc.c

gc-policy.o: gc-policy.c gc.h gc-internal.h
	$(CC) -c $(CFLAGS) -o gc-policy.o gc-policy.c

gc-collect.o: gc-collect.c gc.h gc-internal.h
	$(CC) -c $(CFLAGS) -o gc-collect.o gc-collect.c

gc-compact.o: gc-compact.c gc.h gc-internal.h
	$(CC) -c $(CFLAGS) -o gc-compact.o gc-compact.c

gc-object.o: gc-object.c gc.h gc-internal.h
	$(CC) -c $(CFLAGS) -o gc-object.o gc-object.c

gc-support.o: gc-support.c gc.h gc-internal.h
	$(CC) -c $(CFLAGS) -o gc-support.o gc-support.c

gc-scan.o: gc-scan.c gc.h gc-internal.h
	$(CC) -c $(CFLAGS) -o gc-scan.o gc-scan.c

gc-trace.o: gc-trace.c gc.h gc-internal.h
	$(CC) -c $(CFLAGS) -o gc-trace.o gc-trace.c

gc-utility.o: gc-utility.c gc.h gc-internal.h
	$(CC) -c $(CFLAGS) -o gc-utility.o gc-utility.c

gc-debug.o: gc-debug.c gc.h gc-internal.h
	$(CC) -c $(CFLAGS) -o gc-debug.o gc-debug.c

gc-lang.o: gc-lang.h gc-lang.c gc.h
	$(CC) -c $(CFLAGS) -o gc-lang.o gc-lang.c

gc-test.o: gc.h gc-test.c
	$(CC) -c $(CFLAGS) -o gc-test.o gc-test.c

gc-test: gc-test.o gc.o gc-object.o gc-support.o gc-utility.o gc-debug.o \
	gc-trace.o gc-lang.o gc-collect.o gc-compact.o gc-policy.o \
	gc-compact.o gc-scan.o ../os/os-darwin-x64.o
	$(CC) $(CFLAGS) -o gc-test gc-test.o gc.o gc-utility.o gc-debug.o \
	gc-object.o gc-support.o gc-trace.o gc-lang.o gc-collect.o \
	gc-compact.o gc-scan.o gc-policy.o ../os/os-darwin-x64.o

clean: clean-events clean-coverage
	rm -rf *.o
	rm -rf gc-test
	rm -rf events*.txt

clean-events:
	rm -rf events*.txt

clean-coverage:
	rm -rf *.gcov
	rm -rf *.gcda
	rm -rf *.gcno

