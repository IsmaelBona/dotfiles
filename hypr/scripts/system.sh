#!/bin/bash

# Opciones del menú del sistema
op_reboot="󰜉  Reboot"
op_poweroff="  Power Off"

# Mostrar el menú principal
options="$op_reboot\n$op_poweroff"

chosen=$(echo -e "$options" | rofi -dmenu -i -p "Sistema:")

case $chosen in
    $op_reboot)
        systemctl reboot
        ;;
    $op_poweroff)
        systemctl poweroff
        ;;
esac
