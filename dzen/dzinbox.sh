#!/bin/bash

source ~/dotfiles/theme.sh

inbox=$(~/dotfiles/dzen/inbox.sh ~/mail/in)
if (( $inbox > 0 )); then
    printf "^fg($yellow)^i(/home/ben/dotfiles/dzen/icons/mail.xbm) %s^fg()" $inbox
else
    printf "^fg($blue)^i(/home/ben/dotfiles/dzen/icons/mail.xbm) 0^fg()"
fi
