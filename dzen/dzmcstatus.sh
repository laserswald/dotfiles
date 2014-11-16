source ~/dotfiles/theme.sh
ports=(25565 80 21025)
portservnames=(mc http sb)
printf "^i(/home/ben/dotfiles/dzen/icons/dish.xbm) "
for (( i = 0; i < 3; i++ )); do
    serverlisten=$(netstat -ano | grep "${ports[$i]}" | grep LISTEN)
    if [[ $serverlisten == "" ]]; then
        fgcolor=$off
    else 
        fgcolor=$on
    fi
    printf "^fg($fgcolor)${portservnames[$i]}^fg()" 
    if [[ $i < 2 ]]; then
        printf " "
    fi

done
