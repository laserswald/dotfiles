. ~/.lemonbar/base.sh

ssid=$(nmcli -t -f name,active c | grep yes | cut -d: -f1)
ssid=$(nmcli -t -f name,active c | grep yes | cut -d: -f1)

full=""

if [[ ! $ssid ]]; then
    ssid="---"
fi
show_icon_text $(tcolor brblack) $full "%{A:urxvt -e 'nmtui':}$ssid"

