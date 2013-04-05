#include <stdio.h>
#include <inttypes.h>

long sum(long x, long s, long n) {
	if(x == n)
		return s;
	else
		return sum(x + 1, s + 1, n);
}

int main(int argc, char** argv) {
	long n = strtol(argv[1], 0, 10);
	printf("%ld\n", sum(0, 0, n));
	return 0;
}

