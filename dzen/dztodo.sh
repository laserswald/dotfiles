source ~/dotfiles/theme.sh
action=$(/home/ben/scripts/todo.sh ls | head -1)
echo "^fg($default)na: $action^fg()"
