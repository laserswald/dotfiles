
. ~/dotfiles/theme.sh


function show_item {
    maincolor=$1
    iconname=$2
    text=$3

    echo "%{B$maincolor}%{B-}%{F$maincolor}$text%{F-}"
}
