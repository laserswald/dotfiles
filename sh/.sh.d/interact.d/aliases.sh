# My massive alias file. Viewer beware.

alias e="$EDITOR"
alias edit="$EDITOR"
alias tm="tmux"
alias tmux="tmux -2"
alias tns="tmux new-session -s -A "

alias journal="$EDITOR ~/org/journal.txt"
alias clocksum="hledger -f $HOME/org/work.timedot"

alias ping="ping -c 3"

alias pomo="sleep 10m && notify-send 'Pomodoro done!'"


# OS and package manager specifics.

if command -V 'systemctl' >/dev/null
then
    alias daemons="systemctl list-units"
fi

if command -V 'pacman' >/dev/null
then
    alias pacupd="sudo pacman -Syu && notify-send 'Pacman' 'System update was successful.'"
fi

if command -V 'netctl' >/dev/null
then
    alias nctl="netctl"
fi

# Xorg.

alias xm="xrdb -merge ~/.xrdb.d/main"
alias nwall="feh --random --bg-fill ~/usr/img/wall"
alias rwall="feh --random --bg-fill ~/usr/img/wall"
alias wall="~/.fehbg"

