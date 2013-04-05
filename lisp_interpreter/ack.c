#include <stdio.h>
#include <inttypes.h>

long ack(long m, long n) {
	if(m == 0) return n + 1;
	if(n == 0) return ack(m - 1, 1);
	return ack(m - 1, ack(m, n - 1));
}

int main(int argc, char** argv) {
	long m = strtol(argv[1], 0, 10);
	long n = strtol(argv[2], 0, 10);
	printf("%d\n", ack(m, n));
	return 0;
}
