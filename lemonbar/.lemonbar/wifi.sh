. ~/.lemonbar/base.sh
ssid=$(iw dev wlo1 link | grep SSID | cut -d' ' -f2)

full=""

if [[ ! $ssid ]]; then
    ssid="---" 
fi
show_icon_text $(tcolor brblack) $full "%{A:urxvt -e 'sudo wifi-menu':}$ssid"

