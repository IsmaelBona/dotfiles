#!/bin/bash

# Opciones del menú principal
op_appearance=" Appearance"
op_reboot="󰜉 Reboot"
op_poweroff=" Power Off"

# Mostrar el menú principal
options="$op_appearance\n$op_reboot\n$op_poweroff"

chosen=$(echo -e "$options" | rofi -dmenu -i -p "Sistema:")

case $chosen in
    $op_appearance)
        bash ~/.config/hypr/scripts/appearance.sh
        ;;
    $op_reboot)
        systemctl reboot
        ;;
    $op_poweroff)
        systemctl poweroff
        ;;
esac
