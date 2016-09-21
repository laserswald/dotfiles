#!/bin/sh
xset +fp /usr/share/fonts/local
xset fp rehash

xrdb -merge $HOME/.xrdb.d/main

# Daemons.
syncthing --no-browser &
mpd &
redshift &
dunst &

setxkbmap -option ctrl:nocaps
xcape -e "Control_L=Escape"

# Appearance.

# Set the cursor to the left arrow pointer.
xsetroot -cursor_name left_ptr &

# Launch a compositor. 
# compton -fCc &

# Set up my background. 
sh -c "~/.fehbg" &
# ~/bin/termbg -c red


# Start a minimalist bar.
minbar &

~/.screenlayout/dellnormleft.sh

# Start a tray.
# tray &

# exec ~/bin/backflip
exec gnome-session
