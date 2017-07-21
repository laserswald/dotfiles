#!/bin/sh
. ~/.lemonbar/base.sh

mpd_play_pause () {

    if $(mpc | grep -q "playing") ; then
        icon=""
    else
        icon=""
    fi
    echo "%{A:mpc toggle:} $(show_icon $color "$icon") %{A}"
}

np=$( mpc current --format="%artist% - %title%")
color=$(tcolor green)
if [[ -z $np ]]; then
    np="---"
    color=$(tcolor black)
fi
echo "$(mpd_play_pause)%{B$(tcolor background)}%{F$color}$np %{F-}%{B-}"
