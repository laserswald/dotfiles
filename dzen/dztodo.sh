source ~/dotfiles/theme.sh
action=$(/home/ben/scripts/todo.sh -p ls | head -1)
echo "^fg($default)na: $action^fg()"
