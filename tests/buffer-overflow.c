#include <string.h>
#include <stdlib.h>

static char largerbuf[3060];

int main(int argc, const char *argv[]) {
	char buf[2048];

	memset(largerbuf, 'A', sizeof largerbuf);
	strncpy(buf, largerbuf, sizeof largerbuf);

	// this shouldn't be reachable
	return EXIT_FAILURE;
}
