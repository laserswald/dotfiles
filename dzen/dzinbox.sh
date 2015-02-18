#!/bin/bash

source ~/dotfiles/theme.sh
source ~/dotfiles/dzen/dzbase.sh

inbox=$(~/dotfiles/dzen/inbox.sh ~/mail/in)
if (( $inbox > 0 )); then
    current=$red
else
    current=$base03
fi
show_item $current /home/ben/dotfiles/dzen/icons/mail.xbm $inbox
