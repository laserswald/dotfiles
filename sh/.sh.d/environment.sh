# Environment.
# My default apps and environment variables.

# Prefer Neovim instead of Vim, if it exists.

if command -v nvim >/dev/null 2>&1; then
    EDITOR=nvim
else
    EDITOR=vim
fi

export EDITOR
export VISUAL=$EDITOR

export BROWSER=firefox
export PAGER="less -R"

export GOPATH=~/usr/src/go
export MAIL=~/var/mail
export XDG_CONFIG_HOME="$HOME/.config"

export TERMINAL=st

export PATH="$PATH:$HOME/bin"

# export HISTFILE="$HOME/.shhistory"

export WM="xmonad"
