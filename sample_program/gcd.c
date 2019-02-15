#include <stdio.h>
#include <stdlib.h>

int gcd(int a, int b) {
	while (a != b) {
		if (a > b) a = a - b;
		else b = b - a;
	}
	return a;
}
int main(int argc, char ** argv) {
	printf("%d\n", gcd(atoi(argv[1]), atoi(argv[2])));
	return 0;
}
