#!/bin/sh
# Environment.
# My default apps and environment variables.

preferred_app() {
    for app in $@; do
        if which $app >/dev/null 2>&1; then
            which $app
            return
        fi
    done
}

# Preferred applications
export EDITOR="$(preferred_app kak nvim vis vim vi)"
export VISUAL="$EDITOR"
export BROWSER="firefox"
export PAGER="less -R"
export TERMINAL="$(preferred_app st alacritty termite urxvt xterm)"

# Environmental paths
export SRC_PATH="$HOME/src"
export GOPATH="$SRC_PATH/go"
export MAIL="$HOME/var/mail"
export ORG_PATH="$HOME/org"
export PUNCH_FILE="$ORG_PATH/.punches"

# Desktop stuff
export CLICOLOR=1
export FONT="Tamzen:size=9"
