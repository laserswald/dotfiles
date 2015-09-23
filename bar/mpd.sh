#!/bin/sh
. ~/etc/bar/base.sh
np=$( mpc current --format="%artist% - %title%")
color=$green
if [[ -z $np ]]; then
    np="---"
    color=$black
fi
echo "%{A:mpc toggle:}$(show_icon_text $color "" "$np")%{A}"
