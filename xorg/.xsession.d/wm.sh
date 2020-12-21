#!/bin/sh
##### Programs to be executed only if a WM is being executed

wm_notify() {
    ## Set up my notifier
    dunst &
}

wm_bg() {
    ~/.screenlayout/$(hostname).sh

    ## Set the cursor to the left arrow pointer.
    xsetroot -cursor_name left_ptr &

    ## Set up my background.
    sh -c "~/.fehbg" &
    # ~/bin/termbg -c blue
}

wm_composite(){
    ## Launch a compositor.
    # compton -fCc &
    picom &
}

wm_keybinds(){
    ~/.config/sxhkd/start.sh $WM &
}

wm_tray(){
    ## Start a tray.
    # tray &
    :
}

## Set up the bar

wm_bar(){
    echo "Setting up bar fifo"
    export PANEL_FIFO="/home/lazr/tmp/panel-fifo"
    test -e $PANEL_FIFO && rm $PANEL_FIFO
    mkfifo $PANEL_FIFO

    echo "Starting bar"
    $HOME/.lemonbar/start_bar.sh &
}

wm_polybar(){
    polybar lazr &
}


case $WM in
    nitro)
        wm_notify
        wm_bg
        wm_keybinds
        ;;
    backflip)
        wm_notify
        wm_bg
        wm_keybinds
        ;;
	2bwm)
        wm_notify
        wm_bg
        wm_keybinds
        ;;
    xmonad)
        wm_notify
        wm_bg
        wm_bar
        ;;
    bspwm)
        wm_notify
        wm_bg
        wm_keybinds
        ;;
    i3)
        wm_notify
        wm_bg
        wm_polybar
        ;;
    openbox-session)
        wm_notify
        wm_bg
        ;;
    dwm)
        wm_notify
        wm_bg
        wm_composite
        ~/bin/bar &
        ;;
    ?)
        ### Unrecognized WM.
        ;;
esac

