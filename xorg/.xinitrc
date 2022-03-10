#!/bin/sh
echo "Starting from xinitrc" > .xsession.log
. "$HOME/.xsession"
exec $WM 2>&1 >.xinitrc.errors
