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

alias la="ls -a"
alias ll="ls -l"
alias ls="ls --color=auto -xX"

#Core shortcuts
# ls 
alias ls="ls --color=auto -xX"
alias la="ls -a"

# Directory stack
alias p=pushd
alias o=popd

# Tmux
alias tmux="tmux -2"
alias tm="tmux"
alias tns="tmux new-session -s -A "

# Looks
alias rwall="feh --random --bg-fill ~/usr/img/wall"
alias randw=rwall
alias wall="~/.fehbg"
alias xm="xrdb -merge ~/.xrdb.d/main"

alias ea="e ~/.sh.d/aliases.sh"
alias df="e ~/etc"

## Tools
alias rwall="feh --random --bg-fill ~/usr/img/wall"
alias pomo="sleep 10m && notify-send 'Pomodoro done!'"

# logins
alias p9="drawterm -c gibson.gnot.club -a gibson.gnot.club -u lazr"

# Unsorted.
alias ping="ping -c 3"
alias update="sudo pacman -Syu && notify-send 'Pacman' 'System update was successful.'"
alias wall="~/.fehbg"
alias xm="xrdb -merge ~/.xrdb.d/main"
alias j='jobs -l'
alias h='history'
alias reload="source ~/.profile"
alias rl=reload
