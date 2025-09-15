#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <string.h>

#include "hconfig.h"

static const char* colors[] = {
	HTHEME_BLACK,
	HTHEME_RED,
	HTHEME_GREEN,
	HTHEME_YELLOW,
	HTHEME_BLUE,
	HTHEME_MAGENTA,
	HTHEME_CYAN,
	HTHEME_WHITE,
	HTHEME_BRIGHT_BLACK,
	HTHEME_BRIGHT_RED,
	HTHEME_BRIGHT_GREEN,
	HTHEME_BRIGHT_YELLOW,
	HTHEME_BRIGHT_BLUE,
	HTHEME_BRIGHT_MAGENTA,
	HTHEME_BRIGHT_CYAN,
	HTHEME_BRIGHT_WHITE,
	HTHEME_FOREGROUND,
	HTHEME_BACKGROUND,
};

void die(char *fmt, ...) {
	va_list l;
	va_start(l, fmt);
	vfprintf(stderr, fmt, l);
	va_end(l);
	exit(EXIT_FAILURE);
}

void usage(char *progname, int status) {
	fprintf(stderr, "usage: %s COLOR", progname);
	exit(status);
}

int 
main(int argc, char *argv[]) 
{
	if (argc != 2) {
		usage(argv[0], EXIT_FAILURE);
	}

	if (strcmp(argv[1], "foreground") == 0) {
		puts(colors[16]);
	} else if (strcmp(argv[1], "background") == 0) {
		puts(colors[17]);
	} else {
		char *end = NULL;
		long colornum = strtol(argv[1], &end, 10);
		if (*end != '\0') {
			die("Not recognized: '%s'\n", argv[1]);
		}

		if (colornum > 15 || colornum < 0) {
			die("Not a valid color number: '%i'\n", colornum);
		}

		puts(colors[colornum]);
	}

	return EXIT_SUCCESS;
}
