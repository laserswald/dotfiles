#!/bin/sh
# Autostart script for dwm

$HOME/bin/dwm-status &
runsvdir $HOME/var/pw-service &
dex -a &
