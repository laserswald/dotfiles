#!/bin/sh
. ~/dotfiles/bar/base.sh
np=$( mpc current --format="%artist% / %title%")
color=$green
if [[ -z $np ]]; then
    np="---"
    color=$off
fi
show_item $color "" "$np"
