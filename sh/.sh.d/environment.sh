#!/bin/sh
# Environment.
# My default apps and environment variables.

# Include my preferred XDG directories
export XDG_CONFIG_HOME="$HOME/.config"
if [ -f "$XDG_CONFIG_HOME/user-dirs.dirs" ]; then
    # shellcheck source=/dev/null
    . "$XDG_CONFIG_HOME/user-dirs.dirs"
fi
export XDG_RUNTIME_DIR="$HOME/.local"

# Preferred applications
if command -v nvim >/dev/null 2>&1; then
    export EDITOR='nvim'
else
    export EDITOR='vim'
fi

export BROWSER="firefox"
export SRC_PATH="$HOME/src"
export GOPATH="$SRC_PATH/go"
export MAIL="$HOME/var/mail"
export ORG_PATH="$HOME/org"
export PAGER="less -R"
export PUNCH_FILE="$ORG_PATH/.punches"
export TERMINAL="alacritty"
export VISUAL="$EDITOR"
export WM="xmonad"


export PATH="$HOME/bin:$PATH"

