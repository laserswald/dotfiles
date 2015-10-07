. ~/etc/theme.sh
if [[ $HOSTNAME == "homebase" ]]; then
    echo "homebase bar starting..."
    ~/etc/bar/bar_homebase.sh | lemonbar -b -d -f $font -f $symbolfont
else
    ~/etc/bar/bar_any.sh | lemonbar -b -d -f $font -f $symbolfont
fi

