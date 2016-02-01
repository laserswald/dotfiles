#!/bin/sh
# Laserlights: A unix theme loader.
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

font="-*-coding font tobi-*-*-*-*-*-*-*-*-*-*-*-*"
#font="-*-progsole-*-*-*-*-*-*-*-*-*-*-*-*"
#font="-*-proggyclean-*-*-*-*-*-*-*-*-*-*-*-*"
#font="-*-proggysquare-*-*-*-*-*-*-*-*-*-*-*-*"
#font="-*-pixelcarnagemonott-*-*-*-*-*-*-*-*-*-*-*-*"

symbolfont="-*-stlarch-*-*-*-*-*-*-*-*-*-*-*-*"

# Some default colors for alerts and such.

black=$color0
blue=$color4
brown=$color11
cyan=$color6
green=$color2
grey=$color8
magenta=$color5
orange=$color9
red=$color1
white=$color7
yellow=$color3

alert=$magenta
bg=$black
fg=$white
info=$grey
off=$orange
on=$green
warn=$red
