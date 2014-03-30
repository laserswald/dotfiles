# laserdude's /.xinitrc
#

if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
    eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [-x "$f"] && . "$f"
    done
    unset f
fi

setupTiledWM(){
    echo "Starting tiling windows"
    xcompmgr &
    nitrogen --restore &
    xscreensaver &
    /usr/lib/lxpolkit/lxpolkit &
    wmname LG3D

    if [[ windowmgr == dwm ]]; then
        conky -c ~/.dwmconkyrc | while read -r; do xsetroot -name "$REPLY"; done &
    fi
    ~/bin/notify-listener.py &    
}

setupStandard() {
    if [[ windowmgr == gnome-session ]]; then
        pkill wicd
        NetworkManager &
    fi
    if [[ windowmgr == openbox-session ]]; then
        xscreensaver &
        conky &    
    fi
}

xsetroot -cursor_name left_ptr &
~/.screenlayout/dualhead.sh 
xrdb -merge ~/.Xresources &
twmnd &
if [ -s ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi

case $1 in
cinnamon)
    setupStandard &
    exec gnome-session-cinnamon
    ;;    
gnome)
    setupStandard &
    exec gnome-session
    ;;
xfce)
    setupStandard &
    exec xfce4-session
    ;;
openbox-session)
    setupTiledWM &
    exec openbox-session
    ;;
dwm)
    setupTiledWM &
    # twmnd &
    exec dwm
    ;;
xmonad|*)
    setupTiledWM &
    twmnd &
    exec xmonad
    ;;
esac
