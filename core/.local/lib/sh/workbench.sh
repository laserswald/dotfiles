#! /bin/false

export BENCHNAME=${BENCHNAME:-$(basename $PWD)}

make_wb_folder() {
	mkdir $PWD/.wb
}

start_multiplexer() {
	session=$1
	tmux new-session -d -s $session
}

start_editor() {
	session=$1

    tmux rename-window -t "$session:1" 'edit'
	tmux send-keys -t "$session:edit.1" 'kakp' Enter
}

make_window() {
    session=$1
    name=$2
    cmd=${3:-$SHELL}
 
	tmux new-window -t $session -a -n "$name" "$cmd"
}

make_database_window() {
    make_window $1 'db' 'mysqli'
}

make_vcs_window() {
    make_window $1 'vcs' 'tig'
}

make_shell_window() {
    make_window $1 'shell'
}

make_servers_window() { 
    make_window $1 'srv'
}

wbclose() {
    tmux kill-session -t $BENCHNAME 
}
