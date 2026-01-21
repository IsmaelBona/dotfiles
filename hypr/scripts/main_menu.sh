#!/bin/bash

# Opciones del menú principal
op_update="  Update"
op_appearance="  Appearance"
op_vpn="󰦝  VPN"
op_capture="  Capture"
op_system="  System"

# Mostrar el menú principal
options="$op_update\n$op_appearance\n$op_vpn\n$op_capture\n$op_system"

chosen=$(echo -e "$options" | rofi -dmenu -i -p "Sistema: " -show-icons -theme ~/.config/rofi/basic_menu.rasi)

case $chosen in
    $op_update)
        bash ~/.config/hypr/scripts/update.sh
        ;;
    $op_appearance)
        bash ~/.config/hypr/scripts/appearance.sh
        ;;
    $op_vpn)
        bash ~/.config/hypr/scripts/vpn_selector.sh
        ;;
    $op_capture)
        bash ~/.config/hypr/scripts/capture.sh
        ;;
    $op_system)
        bash ~/.config/hypr/scripts/system.sh
        ;;

esac
