#!/bin/sh
while true; do 
    buffer="%{S1}"
    buffer="${buffer} %{c} $(~/.lemonbar/i3-ws.py 0)"
    buffer="${buffer} %{S0}"
    buffer="${buffer} %{c} $(~/.lemonbar/i3-ws.py 1)"
    echo $buffer
done
