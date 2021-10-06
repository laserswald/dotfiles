#!/bin/sh
# Daemons.

syncthing --no-browser > .syncthing.log &
mpd &
redshift &
battnotifyd &
pipewire &
pipewire-pulse &

xautolock -locker "$HOME/bin/locktool" &

# light-locker &
