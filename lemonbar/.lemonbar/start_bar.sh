
font="-*-clean-medium-r-*-*-12-*-*-*-*-*-*-*"
symbolfont="-*-siji-*-*-*-*-10-*-*-*-*-*-*-*"

if [[ $HOSTNAME == "homebase" ]]; then
    ~/.lemonbar/minimalist.sh | lemonbar -d -g 50x60+3+98 -f "$font" -f "$symbolfont"  | while read ln; do eval "$ln"; done &
else
    ~/.lemonbar/bar_any.sh | lemonbar -d -f "$font" -f "$symbolfont" | while read ln; do eval "$ln"; done &
fi

