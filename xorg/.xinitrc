#!/bin/sh
xset +fp /usr/share/fonts/local
xset fp rehash

xrdb -merge $HOME/.xrdb.d/main

# Daemons.
syncthing --no-browser &
mpd &
redshift &
dunst &

# Appearance.

# Set the cursor to the left arrow pointer.
xsetroot -cursor_name left_ptr &

# Launch a compositor. 
compton &

# Set up my background.
sh -c "~/.fehbg" &

# Start a minimalist bar.
~/bin/minbar.sh &

# Start a tray.
# tray &

exec openbox-session
