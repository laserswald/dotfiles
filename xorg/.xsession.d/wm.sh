#!/bin/sh
##### Programs to be executed only if a WM is being executed

wm_notify() {
    ## Set up my notifier
    dunst &
}

wm_bg() {
    ## Set the cursor to the left arrow pointer.
    xsetroot -cursor_name left_ptr &

    ## Set up my background.
    sh -c "~/.fehbg" &
    # ~/bin/termbg -c red
}

wm_composite(){
    ## Launch a compositor.
    # compton -fCc &
}

wm_keybinds(){
    ~/.config/sxhkd/start.sh $WM &
}

wm_tray(){
    ## Start a tray.
    # tray &
}

wm_bar(){
    ## Start a minimalist bar.
    # minbar &
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
    xmonad)
        wm_notify
        wm_bg
        ;;
    bspwm)
        wm_notify
        wm_bg
        wm_keybinds
        ;;
    i3)
        wm_notify
        wm_bg
        ;;
    ?)
        ### Unrecognized WM.
        ;;
esac

