if ! command -v todo.sh >/dev/null 2>&1
then
	echo "Returning early"
    return
fi

alias t="todo.sh -t"
alias ta="todo.sh add"
alias td="todo.sh do"
alias tl="todo.sh ls"
alias twork="todo.sh ls @work -@waiting"
alias et="$EDITOR $ORG_PATH/todo.txt"

