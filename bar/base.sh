
. ~/etc/theme.sh


function show_icon_text {
    maincolor=$1
    icon=$2
    text=$3

    #echo "%{B$maincolor} $icon %{B-} %{F$maincolor}$text%{F-}"
    echo "%{F$maincolor}$icon $text%{F-}"
}

function show_icon {
    maincolor=$1
    icon=$2

    #echo "%{B$maincolor} $icon %{B-} %{F$maincolor}$text%{F-}"
    echo "%{F$maincolor}$icon%{F-}"
}
