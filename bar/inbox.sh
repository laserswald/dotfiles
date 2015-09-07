#!/bin/bash

. ~/etc/bar/base.sh

inbox=$(~/etc/dzen/inbox.sh ~/mail/inbox)
if (( $inbox > 0 )); then
    current=$magenta
else
    current=$black
fi
show_icon_text $current "" "${inbox}"
