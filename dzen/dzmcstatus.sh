
source ~/dotfiles/theme.sh
serverlisten=$(netstat -ano | grep 25565 | grep LISTEN)
if [[ $serverlisten == "" ]]; then
    echo "[^fg($off)mc^fg()]"
else 
    echo "[^fg($on)mc^fg()]"
fi
