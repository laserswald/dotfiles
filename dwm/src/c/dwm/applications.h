#define TERMINAL_BIN "/usr/local/bin/st"
#define INST_CMD(cmd) { TERMINAL_BIN, "-t", cmd, "-e", cmd, NULL }

static const char scratchpadname[] = "scratchpad";

static const char *dmenucmd[]      = { "/bin/sh", "-c", "dmenu_run", NULL };
static const char *termcmd[]       = { TERMINAL_BIN, NULL };
static const char *browsercmd[]    = { "firefox" , NULL };
static const char *chatcmd[]       = INST_CMD("weechat");
static const char *fmcmd[]         = INST_CMD("ranger");
static const char *lockcmd[]       = { "slock", NULL };
static const char *scratchpadcmd[] = { TERMINAL_BIN, "-t", scratchpadname, NULL };
static const char *searchcmd[]     = { "/usr/bin/env", "surf-ddg", NULL };
static const char *mailcmd[]       = INST_CMD("neomutt");

/* Media key commands. */

static const char *dispup[]        = { "xbacklight", "+", "10", NULL };
static const char *dispdown[]      = { "xbacklight", "-", "10", NULL };
static const char *volup[]         = { "amixer", "set", "Master", "10+", NULL };
static const char *voldown[]       = { "amixer", "set", "Master", "10-", NULL };
static const char *volmute[]       = { "amixer", "set", "Master", "toggle", NULL };
static const char *micmute[]       = { "amixer", "set", "Capture", "toggle", NULL };
static const char *printscr[]      = { "/usr/bin/env", "scrot", NULL };
static const char *media_play[]    = { "/usr/bin/env", "dj", "toggle", NULL };
static const char *media_prev[]    = { "/usr/bin/env", "dj", "prev", NULL };
static const char *media_next[]    = { "/usr/bin/env", "dj", "next", NULL };
