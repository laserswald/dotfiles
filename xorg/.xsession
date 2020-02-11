#!/bin/sh
# global X session startup file.

. "$HOME/.xprofile"

if command -v ck-launch-session >/dev/null; then
    exec ck-launch-session "$WM" 2>>.xsession-errors >>.xsession.log
else
    exec "$WM" 2>>.xsession-errors >>.xsession.log
fi
