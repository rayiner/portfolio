#include <stdio.h>
#include <inttypes.h>
#include <stdlib.h>

long fib(long n) {
	if(n < 2) return n;
	return fib(n - 2) + fib(n - 1);
}

int main(int argc, char** argv) {
  long n = strtol(argv[1], 0, 10);
  printf("%ld\n", fib(n));

  return 0;
}
