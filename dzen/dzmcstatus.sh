source ~/dotfiles/theme.sh
ports=(25565 80 21025)
portservnames=(mc http sb)
for (( i = 0; i < 3; i++ )); do
    serverlisten=$(netstat -ano | grep ${ports[$i]} | grep LISTEN)
    if [[ $serverlisten == "" ]]; then
        printf "^fg($off)${portservnames[$i]}^fg()" 
    else 
        printf "^fg($on)${portservnames[$i]}^fg()" 
    fi
    if [[ $i < 2 ]]; then
        printf " "
    fi
done
