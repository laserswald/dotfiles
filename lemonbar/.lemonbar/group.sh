. ~/etc/bar/base.sh

blinken=""
for grp in 1 2 3 4 5; do
    if grep -q "$grp" /tmp/groups.sh/active ; then
        blinken+=" "
    elif grep -q "$grp" /tmp/groups.sh/all ; then
        blinken+=" "
    else
        blinken+=" "
    fi
done

show_icon_text $bg "$blinken" ""
