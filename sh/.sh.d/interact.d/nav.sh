#!/bin/sh

. "$HOME/.local/lib/sh/command_exists.sh"

alias c=cd
alias ds=dirs
alias pd=pushd
alias po=popd

if command_exists exa; then
    alias ls=exa
    alias la="ls -a"
    alias ll="ls -l"
    alias l="ls"
fi

