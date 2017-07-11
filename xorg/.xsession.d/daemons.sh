#!/bin/sh
# Daemons.

syncthing --no-browser >> .syncthing.log &
mpd &
redshift &
