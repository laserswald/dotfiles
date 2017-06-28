#!/bin/sh
# global X session startup file.

# Source any shell scripts in a dir, for maximum flexibility
if [ -d "$HOME/.xsession.d" ]; then
    for script in "$HOME/.xsession.d/*.sh"; do
        . "$script"
    done
fi

. "${HOME}/.xinitrc"
