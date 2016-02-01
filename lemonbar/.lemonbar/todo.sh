. ~/etc/bar/base.sh
action=$(~/bin/todo.sh -p ls | head -1 | xargs)
show_icon_text $base04 "" "$action"
