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

# Start some personal daemons.
    
    # Simple X Hotkey Daemon
    # sxhkd &

    # Syncthing 
    syncthing --no-browser &

    # Music player
    mpd &

    #
    redshift &

# Appearance.

    # Set the cursor to the left arrow pointer.
    xsetroot -cursor_name left_ptr &
   
    # Launch a system tray.
    stalonetray.sh &

    # Launch a compositor. 
    #xcompmgr -c -f -C &
    #compton -b -C &

    ## Wallpapers

        # Set a random pattern as the wallpaper.
        #sleep 2 && feh --bg-fill --random  ~/img/ptrn/* &

        # Set a light blue as the wallpaper
        #sleep 2 && xsetroot -bg blue -fg grey -mod 2 2 &

        # Set a picture as the wallpaper.
        sleep 2 && feh --bg-fill ~/img/wall/wallhaven-75118.png &

    # Start a minimalist bar.
    sleep 2 && ~/.lemonbar/start_bar.sh &

if [ $HOSTNAME == "fastball" ]; then 
    sleep 2 && xsetroot -bg blue -fg grey -mod 2 2 &
    if [[ $OPENBOX ]]; then
        lxpanel &
        exec openbox-session
    else 
        sxhkd & 
        exec bspwm
    fi
elif [[ $HOSTNAME == "homebase" ]]; then 
    ~/.screenlayout/dellaoc.sh &
    exec bspwm
fi
