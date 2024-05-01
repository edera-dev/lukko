#include <stdlib.h>

int main(int argc, const char *argv[]) {
	void *foo = malloc(128);
	free(foo);
	free(foo);

	// shouldn't get here
	return EXIT_FAILURE;
}
