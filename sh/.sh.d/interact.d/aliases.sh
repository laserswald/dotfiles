# My massive alias file. Viewer beware.

command_exists () {
    command -V '$1' >/dev/null 2>&1
}

alias e="$EDITOR"
alias edit="$EDITOR"
alias tm="tmux"
alias tmux="tmux -2"
alias tns="tmux new-session -s -A "

alias ping="ping -c 3"

alias clocksum="hledger -f $HOME/org/work.timedot"


# OS and package manager specifics.

## Service supervision.

# Systemd.
if command_exists systemctl; then
    alias daemons="systemctl list-units"
fi

## Package management.

# Pacman (and Arch in general)
if command_exists pacman; then
    alias pacupd="sudo pacman -Syu && notify-send 'Pacman' 'System update was successful.'"
fi
if command_exists netctl; then
    alias nctl="netctl"
fi

# Xorg.
alias xm="xrdb -merge ~/.xrdb.d/main"

# Feh.
alias randwall="feh --random --bg-fill ~/usr/img/wall"
alias wall="~/.fehbg"

unset command_exists
