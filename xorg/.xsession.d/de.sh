#!/bin/sh
#### Programs executed when a desktop environment is chosen

case $WM in
    gnome-session)
        ### GNOME
        ;;
    gnome-classic)
        ### GNOME Classic
        ;;
    ?)
        ### Not in this list, do nothing.
        ;;
esac
