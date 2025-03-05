
. "$HOME/.local/lib/sh/command_exists.sh"

if command_exists todo.sh
then
    alias t="todo.sh -t"
    alias ta="todo.sh add"
    alias td="todo.sh do"
    alias tl="todo.sh ls"
    alias twork="todo.sh ls @work -@waiting"
    alias et="$EDITOR $ORG_PATH/todo.txt"
fi
