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

#Add stlarch font!
xset +fp /usr/share/fonts/local
xset fp rehash

#Start some nice daemons. 
sxhkd -c ~/.sxhkdrc &
mpd &
start_tmuxen.sh & 

#Look and feel#{{{
~/.screenlayout/dellaoc.sh &
xsetroot -cursor_name left_ptr
compton -b -C &
sleep 2 && feh --bg-tile --random  ~/img/wall/patterns_dark/* &
#}}}

# Listen for X events and do a flippy thing.
backflip.sh &

exec swm
