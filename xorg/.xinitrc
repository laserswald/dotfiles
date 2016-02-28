#!/bin/sh
xset +fp /usr/share/fonts/local
xset fp rehash

xrdb -merge $HOME/.xrdb.d/main

# Daemons.
syncthing --no-browser &
mpd &
redshift &

# Appearance.

# Set the cursor to the left arrow pointer.
xsetroot -cursor_name left_ptr &

# Launch a compositor. 
compton &

# Set up my background.
.fehbg &

# Start a minimalist bar.
minbar &

# Start a tray.
tray &

exec backflip
