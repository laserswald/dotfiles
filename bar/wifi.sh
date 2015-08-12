. ~/etc/bar/base.sh
ssid=$(iw dev wlp3s0 link | grep SSID | cut -d' ' -f2)

full=""

if [[ ! $ssid ]]; then
    ssid="---" 
fi
show_icon_text $grey $full $ssid

