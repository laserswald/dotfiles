
source ~/dotfiles/theme.sh
ports=[25565 80]
portservnames=[mc http]
printf "["
for (( i = 0; i < 2; i++ )); do
    serverlisten=$(netstat -ano | grep ${ports[$i]} | grep LISTEN)
    if [[ $serverlisten == "" ]]; then
        printf "^fg($off)${portservnames[$i]}^fg()" 
    else 
        printf "^fg($on)${portservnames[$i]}^fg()" 
    fi
done
printf "]"
