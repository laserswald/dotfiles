source ~/dotfiles/dzen/dzbase.sh
action=$(~/scripts/todo.sh -p ls | head -1 | xargs)
show_item $base04 ~/dotfiles/dzen/icons/next.xbm "$action"
