#!/bin/sh
. ~/.lemonbar/base.sh
TODO_FILTER=${TODO_FILTER:-"-@work -+homerun"}
action=$(~/bin/todo.sh -p ls $TODO_FILTER | head -1 | tr -d "\r\n")
show_icon_text $base04 "" "$action"
