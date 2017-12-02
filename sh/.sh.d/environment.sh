#!/bin/sh
# Environment.
# My default apps and environment variables.

# Include my preferred XDG directories
export XDG_CONFIG_HOME="$HOME/.config"
if [ -f "$XDG_CONFIG_HOME/user-dirs.dirs" ]; then
    # shellcheck source=/dev/null
    . "$XDG_CONFIG_HOME/user-dirs.dirs"
fi

# Preferred applications
if command -v nvim >/dev/null 2>&1; then
    export EDITOR='nvim'
else
    export EDITOR='vim'
fi

export VISUAL="$EDITOR"
export BROWSER="firefox"
export PAGER="less -R"
export TERMINAL="alacritty"
export WM="xmonad"

# Environmental paths
export SRC_PATH="$HOME/src"
export MAIL="$HOME/var/mail"
export GOPATH="$SRC_PATH/go"
export ORG_PATH="$HOME/org"
export PUNCH_FILE="$ORG_PATH/.punches"

export PATH="$PATH:$HOME/bin"

