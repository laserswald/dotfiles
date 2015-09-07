#!/bin/sh
. ~/etc/bar/base.sh
np=$( mpc current --format="%artist% - %title%")
color=$green
if [[ -z $np ]]; then
    np="---"
    color=$black
fi
show_icon_text $color "" "$np"
