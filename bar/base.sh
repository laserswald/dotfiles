
. ~/dotfiles/theme.sh


function show_item {
    maincolor=$1
    icon=$2
    text=$3

    #echo "%{B$maincolor} $icon %{B-} %{F$maincolor}$text%{F-}"
    echo "%{F$maincolor}// $icon $text%{F-}"
}
