#!/bin/bash

source ~/dotfiles/theme.sh

inbox=$(~/dotfiles/dzen/inbox.sh ~/mail/bdr)
if (( $inbox > 0 )); then
    printf "^fg($yellow)^i(/home/ben/dotfiles/dzen/sm4tik-icon-pack/xbm/mail.xbm) %s^fg()" $inbox
else
    printf "^fg($blue)^i(/home/ben/dotfiles/dzen/sm4tik-icon-pack/xbm/mail.xbm) 0^fg()"
fi
