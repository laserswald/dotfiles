# laserdude's /.xinitrc
#


# Use the window manager given or 
windowmgr=$1
if [[ $windowmgr == "" ]]; then
    windowmgr="xmonad"
fi

setupTiledWM(){
    echo "Starting tiling windows"
    nitrogen --restore &
    xscreensaver &

    # tiling window manager specific stuff here.    

    if [[ windowmgr == dwm ]]; then
        conky -c ~/.dwmconkyrc | while read -r; do xsetroot -name "$REPLY"; done &
    fi
        
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
# Set the cursor to the left pointer.
xsetroot -cursor_name left_ptr &
# Merges the X server resources.
xrdb -merge ~/.Xresources &
~/.screenlayout/dualhead.sh
#start the window manager.
case windowmgr in
cinnamon)
    setupStandard &
    exec gnome-session-cinnamon
    ;;    
gnome)
    setupStandard &
    exec gnome-session
    ;;
xmonad|*)
    setupTiledWM &
    exec xmonad
    ;;

esac
