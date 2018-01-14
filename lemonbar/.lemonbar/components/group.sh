. ~/.lemonbar/base.sh
printf " "
for grp in 1 2 3 4 5; do
    if grep -q "$grp" /tmp/groups/active ; then
        show_icon $(tcolor "color$grp") " "
    elif grep -q "$grp" /tmp/groups/all ; then
        show_icon $(tcolor "color$grp") " "
    else
        show_icon $(tcolor "color$grp") " "
    fi
done
printf " "

