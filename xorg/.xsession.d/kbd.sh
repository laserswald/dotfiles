#!/bin/sh
setxkbmap -option ctrl:nocaps
xcape -e "Control_L=Escape"

xbindkeys -f $HOME/.xbindkeysrc

