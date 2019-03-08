#include <iostream>

using namespace std;

int main(void) {
	int i;	int &j = i;
	i = 2;	j = 3;
	cout << i << endl;
	return 0;
}
