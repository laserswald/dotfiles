source ~/dotfiles/theme.sh
action=$(todoc -f ~/org/todo.txt -p ls | head -1)
echo "^i(/home/ben/dotfiles/dzen/sm4tik-icon-pack/xbm/info_03.xbm) $action"
echo "$action"
