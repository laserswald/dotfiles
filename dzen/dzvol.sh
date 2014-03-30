#!/bin/sh

volpercent=$( amixer sget Master | grep "%" | sed "s/.*\[\([0-9].*\)%\].*/\1/" )

echo "^i(/home/ben/dotfiles/dzen/sm4tik-icon-pack/xbm/spkr_03.xbm) $volpercent"
