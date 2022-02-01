#define TERMINAL_BIN "/usr/bin/alacritty"
#define INST_CMD(cmd) { TERMINAL_BIN, "-T", cmd, cmd, NULL }

static const char scratchpadname[] = "scratchpad";

// static const char *dmenucmd[]       = { "/bin/sh", "-c", "rofi -show run", NULL };
static const char *dmenucmd[]      = { "/bin/sh", "-c", "dmenu_run", NULL };
static const char *termcmd[]       = { "/usr/local/bin/tabbed", "st", "-w", NULL };
static const char *browsercmd[]    = { "/usr/local/bin/tabbed", "surf", "-e", NULL };
static const char *chatcmd[]       = INST_CMD("wee");
static const char *fmcmd[]         = INST_CMD("ranger");
static const char *lockcmd[]       = { "light-locker-command", "-l", NULL };
static const char *scratchpadcmd[] = INST_CMD("scratchpad");
static const char *searchcmd[]     = { "/usr/bin/env", "web-search", NULL };
static const char *mailcmd[]       = INST_CMD("neomutt");

/* Media key commands. */
static const char *dispup[]        = { "xbacklight", "+", "10", NULL };
static const char *dispdown[]      = { "xbacklight", "-", "10", NULL };

static const char *printscr[]      = { "/usr/bin/env", "scrot", NULL };

static const char *volup[]         = { "/usr/bin/env", "audioctl", "up", NULL };
static const char *voldown[]       = { "/usr/bin/env", "audioctl", "down", NULL };
static const char *volmute[]       = { "/usr/bin/env", "audioctl", "mute", NULL };
static const char *micmute[]       = { "/usr/bin/env", "audioctl", "mictoggle", NULL };

static const char *media_play[]    = { "/usr/bin/env", "dj", "toggle", NULL };
static const char *media_prev[]    = { "/usr/bin/env", "dj", "prev", NULL };
static const char *media_next[]    = { "/usr/bin/env", "dj", "next", NULL };
