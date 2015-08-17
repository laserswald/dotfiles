#!/bin/sh
# Default stuff. {{{
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi
#}}}

# Add third party fonts!
xset +fp /usr/share/fonts/local
xset fp rehash

#Start some nice daemons. 
sxhkd -c ~/.sxhkdrc &
syncthing --no-browser &
mpd &
# start_tmuxen.sh & 

#### Look and feel  {{{

# ~/.screenlayout/dellaoc.sh &
xsetroot -cursor_name left_ptr
compton -b -C &

## Wallpapers

# Set a light green as the wallpaper
# xsetroot -bg green -fg grey -mod 2 2

# Set a random pattern as the wallpaper.
sleep 2 && feh --bg-tile --random  ~/usr/img/ptrn/* &

# Stand alone tray!
# ~/bin/stalonetray.sh &

# ~/etc/start_bar.sh &

#}}}

# Listen for X events and do a flippy thing.
# backflip.sh &
exec i3
