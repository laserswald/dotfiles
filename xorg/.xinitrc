#!/bin/sh
<<<<<<< HEAD
xset +fp /usr/share/fonts/local
xset fp rehash

xrdb -load "$HOME/.xrdb.d/main"

# Daemons.
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
# minbar &

~/.screenlayout/dellnormleft.sh &

# Start a tray.
# tray &

exec openbox-session

=======

export WM=${1:-xmonad}

. "$HOME/.xsession"


exec $WM
>>>>>>> 4925f7d367d55a7d40da35fde599fb512071e81b
