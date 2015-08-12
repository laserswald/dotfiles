#!/bin/sh
# theme.sh: A full platform theme loader.
# 
# Copyright 2015 Ben Davenport-Ray
#
# Licensed under the "THE BEER-WARE LICENSE" (Revision 42):
# Ben Davenport-Ray wrote this file. As long as you retain this notice you
# can do whatever you want with this stuff. If we meet some day, and you think
# this stuff is worth it, you can buy me a beer or coffee in return


#source a specially formatted theme file.
source ~/etc/themes/neon.sh

# Select a font. 

# font="-*-progsole-*-*-*-*-*-*-*-*-*-*-*-*"
 font="-*-proggyclean-*-*-*-*-*-*-*-*-*-*-*-*"
# font="-*-proggysquare-*-*-*-*-*-*-*-*-*-*-*-*"
# font="-*-pixelcarnagemonott-*-*-*-*-*-*-*-*-*-*-*-*"

symbolfont="-*-stlarch-*-*-*-*-*-*-*-*-*-*-*-*"

# Some default colors for alerts and such.

black=$color0
grey=$color8
red=$color1
orange=$color9
yellow=$color3
green=$color2
cyan=$color6
blue=$color4
magenta=$color5
brown=$color11
white=$color7

bg=$black
fg=$white
info=$grey
warn=$red
alert=$magenta
on=$green
off=$orange
