# Laserswald's standard profile. This is loaded only once.

if [ $LAZR_PROFILE_LOADED -eq 1 ]; then
    return 0
fi

# I always use US, UTF-8 for my locale.
export LC_CTYPE="en_US.UTF-8"

# ENV is sourced by some shells on startup. This sets it to my shell-agnostic
# startup file. This startup file should be ran every time we have a new shell,
# not upon login (which is what .profile is for, aka this file you are reading rn)
export ENV="$HOME/.shrc"

# Add the shell library for manipulating the PATH 
. ~/.local/lib/sh/path.sh

# If we have the environment variable drop-in directory available, then
# load everything in that directory.
[ -d "$HOME/.sh.d/env.d" ] && source_dir "$HOME/.sh.d/env.d"

# Same for on-login stuff.
[ -d "$HOME/.sh.d/login.d" ] && source_dir "$HOME/.sh.d/login.d"


[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

export LAZR_PROFILE_LOADED=1
