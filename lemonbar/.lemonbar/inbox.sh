#!/bin/bash

. ~/.lemonbar/base.sh

inbox=$(~/etc/dzen/inbox.sh ~/mail/inbox)
if (( $inbox > 0 )); then
    current=$(tcolor magenta)
else
    current=$(tcolor black)
fi
show_icon_text $current "" "${inbox}"
