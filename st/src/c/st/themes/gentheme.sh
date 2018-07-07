#!/bin/sh

template='
/* Terminal colors (16 first used in escape sequence) */
const char *colorname[] = {
	/* 8 normal colors */
	"$BLACK",
	"$RED",
	"$GREEN",
	"$YELLOW",
	"$BLUE",
	"$MAGENTA",
	"$CYAN",
	"$WHITE",

	/* 8 bright colors */
	"$BRBLACK",
	"$BRRED",
	"$BRGREEN",
	"$BRYELLOW",
	"$BRBLUE",
	"$BRMAGENTA",
	"$BRCYAN",
	"$BRWHITE",

	[255] = 0,

	/* more colors can be added after 255 to use with DefaultXX */
	"$FOREGROUND",
	"$BACKGROUND",
	"$CURSOR",
	"$REVCURSOR",
};
'

export BLACK=$(tcolor 'black')
export RED=$(tcolor 'red')
export GREEN=$(tcolor 'green')
export YELLOW=$(tcolor 'yellow')
export BLUE=$(tcolor 'blue')
export MAGENTA=$(tcolor 'purple')
export CYAN=$(tcolor 'cyan')
export WHITE=$(tcolor 'white')
export BRBLACK=$(tcolor 'brblack')
export BRRED=$(tcolor 'brred')
export BRGREEN=$(tcolor 'brgreen')
export BRYELLOW=$(tcolor 'bryellow')
export BRBLUE=$(tcolor 'brblue')
export BRMAGENTA=$(tcolor 'brpurple')
export BRCYAN=$(tcolor 'brcyan')
export BRWHITE=$(tcolor 'brwhite')
export FOREGROUND=$(tcolor 'foreground')
export BACKGROUND=$(tcolor 'background')
export CURSOR="#ffffff"
export REVCURSOR="#000000"

echo "$template" | envsubst
