#!/bin/bash

source ~/dotfiles/theme.sh

inbox=$(~/dotfiles/dzen/inbox.sh ~/mail/bdr)
if (( $inbox > 0 )); then
    printf "^fg($yellow)mail:%s^fg()" $inbox
else
    printf "^fg($blue)mail:0^fg()"
fi
