# Alias file. 
# 

# Shortcuts and colors.
    # ls 
    alias ls="ls --color=auto -xX"
    alias l="ls -a"

    # Todo.sh
    alias t="todo.sh"
    alias ta="t add"
    alias td="t do"
    alias tl="t ls"

    alias ping="ping -c 3"

    # Tmux
alias tmux="tmux -2"
alias tm="tmux"
alias tns="tmux new-session -s -A "

alias nctl="netctl"

alias ea="$EDITOR ~/.sh.d/aliases.sh"
alias ei3="$EDITOR ~/dotfiles/i3/config"
alias rwall="feh --random --bg-fill ~/usr/img/wall"

# Pacman! 
alias pacupd="sudo pacman -Syu && notify-send 'Pacman' 'System update was successful.'"
alias pacref="sudo pacman -Syy"

alias pomo="sleep 10m && notify-send 'Pomodoro done!'"
alias reload="source ~/.profile"
alias rwall="feh --random --bg-fill ~/usr/img/wall"
alias sctl="systemctl"
alias sctll="systemctl list-units"
alias wall="~/.fehbg"
alias xm="xrdb -merge ~/.xrdb.d/main"
alias eclimd="/usr/lib/eclipse/eclimd &"
alias e=$EDITOR
alias p9="drawterm -c gibson.gnot.club -a gibson.gnot.club -u lazr"
