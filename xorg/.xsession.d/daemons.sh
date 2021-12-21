#!/bin/sh
# Daemons.

mpd &
redshift &
battnotifyd &

runsvdir "$HOME/var/service" &

xautolock -locker "$HOME/bin/locktool" &

# light-locker &
