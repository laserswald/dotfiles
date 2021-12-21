#!/bin/sh

template='
static const char normfg[] = "$FOREGROUND";
static const char normbg[] = "$BACKGROUND";
static const char normborder[] = "$BLACK";
static const char selfg[] = "$BRWHITE";
static const char selbg[] = "$CYAN";
static const char selborder[] = "$CYAN";
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
