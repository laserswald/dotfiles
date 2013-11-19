# laserdude's /.xinitrc
#

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [-x "$f"] && . "$f"
    done
    unset f
fi

setupTiledWM(){
    echo "Starting tiling windows"
    nitrogen --restore &
    xscreensaver &
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
openbox)
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
    # twmnd &
    exec xmonad
    ;;
esac
