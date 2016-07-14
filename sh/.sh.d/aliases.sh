# Alias file. 
# 

#Core shortcuts
alias e=$EDITOR
alias ping="ping -c 3"

# ls 
alias ls="ls --color=auto -xX"
alias l="ls -l"
alias la="ls -a"

# Directory stack
alias p=pushd
alias o=popd

# Todo.sh
alias t="todo.sh"
alias ta="t add"
alias td="t do"
alias tl="t ls"

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
alias nctl="netctl"

#Tools
alias pomo="sleep 10m && notify-send 'Pomodoro done!'"
alias reload="source ~/.profile"
alias eclimd="/usr/lib/eclipse/eclimd &"
alias p9="drawterm -c gibson.gnot.club -a gibson.gnot.club -u lazr"

# Pacman
alias pacupd="sudo pacman -Syu && notify-send 'Pacman' 'System update was successful.'"
alias pacref="sudo pacman -Syy"

# System administration
alias sctl="systemctl"
alias sctll="systemctl list-units"
