#include <stdio.h>
#define MAX(a,b) ((a) > (b) ? (a) : (b))

int main(void) {
	int x = 5;
	int y = 3;
	printf("MAX(%d++, %d++) = %d\n", x, y, MAX(x++, y++));
	return 0;
}
