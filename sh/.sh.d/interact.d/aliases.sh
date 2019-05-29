alias c=cd
alias ds=dirs
alias dvtm="dvtm -m ^a -M"
alias p=pushd
alias o=popd
alias h='history'
alias j='jobs -l'
alias reload=". ~/.profile"
alias rl=reload

alias ls='ls --color=auto'
alias l=ls
alias la="ls -a"
alias ll="ls -l"

alias edit="$EDITOR"
alias e="edit"
alias df="edit ~/etc"

alias ping="ping -c 3"
alias randw=rwall
alias rwall="feh --random --bg-fill ~/usr/img/wall"

alias t="todo.sh -t"
alias ta="t add"
alias td="t do"
alias tl="t ls"
alias twork="tl @work -@waiting"
alias et="e $ORG_PATH/todo.txt"

alias mux="$MULTIPLEXER"
alias tm="tmux"
alias tmux="tmux -2"
alias tns="tmux new-session -s -A "
alias update="sudo pacman -Syu && notify-send 'Pacman' 'System update was successful.'"
alias wall="~/.fehbg"
alias xm="xrdb -merge ~/.xrdb.d/main"
