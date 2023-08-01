#!/bin/sh
# global X session startup file.

[ -f "$HOME/.xprofile" ] && . "$HOME/.xprofile"

exec dbus-run-session "$WM" 2>>.xsession-errors >>.xsession.log
