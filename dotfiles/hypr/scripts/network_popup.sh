#!/bin/bash
IFACE=$(nmcli -t -f DEVICE,TYPE,STATE d | grep ":connected" | cut -d: -f2)

if [[ "$IFACE" == "wifi" ]]; then
    # Lista redes Wi-Fi no Wofi
    SSID=$(nmcli -t -f SSID,SIGNAL,SECURITY device wifi list | awk -F: '{printf "%-30s %3s%%  [%s]\n", $1, $2, $3}' | rofi -dmenu -prompt "Wi-Fi" -lines 10 -width 40%)
    [ -z "$SSID" ] && exit
    nmcli device wifi connect "$SSID"
else
    # Ethernet info
    INFO=$(nmcli -t -f GENERAL.DEVICE,GENERAL.CONNECTION,IP4.ADDRESS,IP4.GATEWAY device show | grep -v '^--')
    echo "$INFO" | rofi -dmenu -prompt "Ethernet Info" -lines 10 -width 40%
fi
