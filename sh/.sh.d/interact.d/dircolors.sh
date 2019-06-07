#!/bin/false
# Set up colors in `ls`

if [ $(uname) = "Linux" ]; then
    test -r "$HOME/.dircolors" && eval "$(dircolors "$HOME/.dircolors")"
    alias ls="ls --color=auto"
else
    alias ls="ls -G"
fi
