. ~/dotfiles/bar/base.sh
action=$(~/bin/todo.sh -p ls | head -1 | xargs)
show_item $base04 "" "$action"
