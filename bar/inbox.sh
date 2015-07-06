#!/bin/bash

. ~/dotfiles/bar/base.sh

inbox=$(~/dotfiles/dzen/inbox.sh ~/mail/Inbox)
if (( $inbox > 0 )); then
    current=$red
else
    current=$off
fi
show_item $current "icon" "${inbox}"
