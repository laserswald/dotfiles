#!/bin/sh

export WM=${1:-xmonad}

. "$HOME/.xsession"


exec $WM
