#!/bin/sh

volpercent=$( amixer sget Master | grep "Front Left:" | sed "s/.*\[\([0-9].*\)%\].*/\1/" )

echo "^i(/home/ben/dotfiles/dzen/icons/spkr_03.xbm) $volpercent"
