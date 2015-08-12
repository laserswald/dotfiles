#!/bin/bash

. ~/etc/bar/base.sh

inbox=$(~/etc/dzen/inbox.sh ~/mail/Inbox)
if (( $inbox > 0 )); then
    current=$red
else
    current=$off
fi
show_item_text $current "" "${inbox}"
