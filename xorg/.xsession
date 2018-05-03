#!/bin/sh
# global X session startup file.

. "$HOME/.profile"

# exec >>.xsession.log
exec 2>&1

echo "Starting X Session"

#export WM="backflip"
# WM="i3"
# WM="openbox-session"
# WM="gnome-session"
export WM="i3"

# Source any shell scripts in a dir, for maximum flexibility
if [ -d "$HOME/.xsession.d" ]; then
    for script in $HOME/.xsession.d/*.sh; do
        echo "Sourcing module $script"
        set +x
        . "$script"
        set -x
    done
fi


echo "Starting desktop $WM"
exec ck-launch-session "$WM"
