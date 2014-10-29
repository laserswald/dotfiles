source ~/dotfiles/theme.sh
action=$(todoc -f ~/org/todo.txt -p ls | head -1)
echo "$action"
