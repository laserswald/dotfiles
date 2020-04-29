#define TERMINAL_BIN "/usr/local/bin/st"
#define INST_CMD(cmd) { TERMINAL_BIN, "-t", cmd, "-e", cmd, NULL }

static const char scratchpadname[] = "scratchpad";

static const char *dmenucmd[]      = { "/bin/sh", "-c", "dmenu_run", NULL };
static const char *termcmd[]       = { TERMINAL_BIN, NULL };
static const char *browsercmd[]    = { "firefox" , NULL };
static const char *chatcmd[]       = INST_CMD("wee");
static const char *fmcmd[]         = INST_CMD("ranger");
static const char *lockcmd[]       = { "slock", NULL };
static const char *scratchpadcmd[] = INST_CMD("scratchpad");
static const char *searchcmd[]     = { "/usr/bin/env", "surf-ddg", NULL };
static const char *mailcmd[]       = INST_CMD("neomutt");

/* Media key commands. */
static const char *dispup[]        = { "xbacklight", "+", "10", NULL };
static const char *dispdown[]      = { "xbacklight", "-", "10", NULL };

static const char *printscr[]      = { "/usr/bin/env", "scrot", NULL };

static const char *volup[]         = { "/usr/bin/env", "audiomixer", "volup", NULL };
static const char *voldown[]       = { "/usr/bin/env", "audiomixer", "voldown", NULL };
static const char *volmute[]       = { "/usr/bin/env", "audiomixer", "voltoggle", NULL };
static const char *micmute[]       = { "/usr/bin/env", "audiomixer", "mictoggle", NULL };

static const char *media_play[]    = { "/usr/bin/env", "dj", "toggle", NULL };
static const char *media_prev[]    = { "/usr/bin/env", "dj", "prev", NULL };
static const char *media_next[]    = { "/usr/bin/env", "dj", "next", NULL };
