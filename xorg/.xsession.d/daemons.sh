#!/bin/sh
# Daemons.

mpd &
redshift &
battnotifyd &

runsvdir "$HOME/var/pw-service" &
xautolock -locker "$HOME/bin/locktool" &
# light-locker &
