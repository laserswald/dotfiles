# Library for building bar interfaces. 
. ~/etc/theme.sh

function show_icon_text {
    maincolor=$1
    icon=$2
    text=$3

    #echo "%{B$maincolor} $icon %{B-} %{F$maincolor}$text%{F-}"
    echo "%{B$maincolor} $icon $text %{B-}"
}

function show_icon {
    maincolor=$1
    icon=$2

    #echo "%{B$maincolor} $icon %{B-} %{F$maincolor}$text%{F-}"
    echo "%{F$maincolor}$icon%{F-}"
}

function str_contains(){
    str="$1"
    sub="$2"
    if test "${str#*$sub}" != "$str"; then
        return 0
    else
        return 1
    fi
}

