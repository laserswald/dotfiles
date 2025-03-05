#!/bin/sh
. "$HOME/.local/lib/sh/command_exists.sh"

if command_exists nnn
then
    alias nnn="nnn -e"
fi
