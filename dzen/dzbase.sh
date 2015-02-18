
source ~/dotfiles/theme.sh

function show_item {
    maincolor=$1
    iconname=$2
    text=$3

    printf "^bg($maincolor) ^i($iconname) ^bg()^fg($maincolor) $text^fg()"
}
