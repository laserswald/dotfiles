m4 -I $(dirname $0) -D WM=$1 ~/.config/sxhkd/sxhkd.m4 >~/.config/sxhkd/sxhkdrc
chmod +x ~/.config/sxhkd/sxhkdrc
if pgrep sxhkd; then
	pkill -USR1 sxhkd
else 
    sxhkd -c ~/.config/sxhkd/sxhkdrc &
fi
