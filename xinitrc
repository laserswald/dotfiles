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

# Add third party fonts!#{{{
xset +fp /usr/share/fonts/local
xset fp rehash
#}}}

#Start some nice daemons. {{{
sxhkd &
syncthing --no-browser &
mpd &
#}}}

# Look and feel. {{{

xsetroot -cursor_name left_ptr &
stalonetray.sh
#compton -b -C &

## Wallpapers
# Set a light blue as the wallpaper
sleep 2 && xsetroot -bg blue -fg grey -mod 2 2 &
# Set a random pattern as the wallpaper.
# sleep 2 && nwall &

# shoutout.sh &

#}}}
sleep 2 && ~/etc/start_bar.sh &
if [ $HOSTNAME == "fastball" ]; then 
    if [[ $OPENBOX ]]; then
        lxpanel &
        exec openbox-session
    else 
        exec bspwm -c "~/.config/bspwm/bspwmrc"
    fi
elif [[ $HOSTNAME == "homebase" ]]; then 
    ~/.screenlayout/dellaoc.sh &
    exec bspwm
fi
