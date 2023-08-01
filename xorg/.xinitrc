#!/bin/sh
echo "Starting from xinitrc" > .xsession.log
. "$HOME/.xsession"
exec dbus-run-session $WM 2>&1 >.xinitrc.errors
# exec dbus-launch --exit-with-session "$WM" 2>>.xsession-errors >>.xsession.log
