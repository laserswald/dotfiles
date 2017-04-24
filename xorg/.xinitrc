#!/bin/sh
xset +fp /usr/share/fonts/local
xset fp rehash

xrdb -merge "$HOME/.xrdb.d/main"

# Daemons.
syncthing --no-browser &
mpd &
redshift &
dunst &

setxkbmap -option ctrl:nocaps &
xcape -e "Control_L=Escape" &

# Appearance.

# Set the cursor to the left arrow pointer.
xsetroot -cursor_name left_ptr &

# Launch a compositor.
# compton -fCc &

# Set up my background.
# sh -c "$HOME/.fehbg" &
~/bin/termbg -c blue


# Start a minimalist bar.
minbar &

~/.screenlayout/dellnormleft.sh &

# Start a tray.
# tray &

#exec ~/bin/backflip
#export XDG_CURREENT_DESKTOP=GNOME-Classic:GNOME
#export GNOME_SHELL_SESSION_MODE=classic
exec xmonad
