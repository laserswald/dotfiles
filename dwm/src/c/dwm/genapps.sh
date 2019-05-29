#!/bin/sh

template='
#define INST_CMD(cmd) { "$TERMINAL", "-name", cmd, "-e", cmd, NULL }
static const char *termcmd[]    = { "$TERMINAL", NULL };
static const char *dmenucmd[]   = { "/bin/sh", "-c", "dmenu_run", NULL };
static const char *lockcmd[]    = { "xlock", "-mode", "galaxy", NULL };
static const char *searchcmd[]  = { "env", "surf-ddg", NULL };
static const char *chatcmd[]    = INST_CMD("weechat");
static const char *fmcmd[]      = INST_CMD("ranger");
static const char *browsercmd[] = { "$BROWSER" , NULL };
'

echo "$template" | envsubst
