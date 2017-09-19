#!/bin/sh
# global X session startup file.

. "$HOME/.profile"

exec >>.xsession.log
exec 2>&1

echo "Starting X Session"

WM="backflip"

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
exec "$WM"
