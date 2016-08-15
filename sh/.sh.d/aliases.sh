# Aliases

## Daemons
alias eclimd="/usr/lib/eclipse/eclimd &"

## Shortcuts.

### Editor
alias ea="$EDITOR ~/.sh.d/aliases.sh"
alias edit=$EDITOR
alias e=$EDITOR

#### Edit configs
alias ei3="$EDITOR ~/etc/i3/.i3/config"
alias exm="$EDITOR ~/etc/xmonad/.xmonad/xmonad.hs"

alias l="ls -a"
alias ls="ls --color=auto -xX"

## System
alias nctl="netctl"
alias pacref="sudo pacman -Syy"
alias sctll="systemctl list-units"
alias sctl="systemctl"

## Tools
alias rwall="feh --random --bg-fill ~/usr/img/wall"
alias pomo="sleep 10m && notify-send 'Pomodoro done!'"

# logins
alias p9="drawterm -c gibson.gnot.club -a gibson.gnot.club -u lazr"

# Unsorted.
alias ping="ping -c 3"
alias ta="t add"
alias td="t do"
alias tl="t ls"
alias tm="tmux"
alias tmux="tmux -2"
alias tns="tmux new-session -s -A "
alias t="todo.sh"
alias update="sudo pacman -Syu && notify-send 'Pacman' 'System update was successful.'"
alias wall="~/.fehbg"
alias xm="xrdb -merge ~/.xrdb.d/main"
alias j='jobs -l'
alias h='history'
alias reload="source ~/.profile"
alias rl=reload
