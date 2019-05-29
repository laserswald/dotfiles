#define TERMINAL_BIN "/usr/bin/alacritty"
#define INST_CMD(cmd) { TERMINAL_BIN, "-t", cmd, "-e", cmd, NULL }

static const char scratchpadname[] = "scratchpad";

static const char *dmenucmd[]      = { "/bin/sh", "-c", "dmenu_run", NULL };
static const char *browsercmd[]    = { "firefox" , NULL };
static const char *chatcmd[]       = INST_CMD("weechat");
static const char *fmcmd[]         = INST_CMD("ranger");
static const char *lockcmd[]       = { "slock", NULL };
static const char *scratchpadcmd[] = { TERMINAL_BIN, "-t", scratchpadname, NULL };
static const char *searchcmd[]     = { "/usr/bin/env", "surf-ddg", NULL };
static const char *termcmd[]       = { TERMINAL_BIN, NULL };

