. ~/etc/theme.sh

mkfifo barcmds.ffo

if [[ $HOSTNAME == "homebase" ]]; then
    echo "homebase bar starting..."
    ~/etc/bar/bar_homebase.sh | lemonbar -b -d -f "$font" -f "$symbolfont" | while read ln; do eval "$ln"; done &
else
    ~/etc/bar/bar_any.sh | lemonbar -b -d -f "$font" -f "$symbolfont" | while read ln; do eval "$ln"; done &
fi

