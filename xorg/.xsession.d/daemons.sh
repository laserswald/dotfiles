#!/bin/sh
# Daemons.

syncthing --no-browser > .syncthing.log &
mpd &
redshift &
battnotifyd &

xautolock -locker "$HOME/bin/locktool" &

# light-locker &
