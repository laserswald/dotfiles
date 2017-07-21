. ~/.lemonbar/base.sh
ports=(25565 80 21025)
portservnames=(mc http sb)
for (( i = 0; i < 3; i++ )); do
    serverlisten=$(netstat -ano | grep "${ports[$i]}" | grep LISTEN)
    if [[ $serverlisten == "" ]]; then
        fgcolor=$off
    else 
        fgcolor=$on
    fi
    show_item $fgcolor "" "${portservnames[$i]}" 
    if [[ $i < 2 ]]; then
        printf " "
    fi

done
