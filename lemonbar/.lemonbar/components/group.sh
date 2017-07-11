. ~/.lemonbar/base.sh

blinken=""
for grp in 1 2 3 4 5; do
    if grep -q "$grp" /tmp/groups/active ; then
        blinken+=" "
    elif grep -q "$grp" /tmp/groups/all ; then
        blinken+=" "
    else
        blinken+=" "
    fi
done

show_icon_text $(tcolor blue) "$blinken" ""
