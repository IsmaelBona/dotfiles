#!/bin/bash

# Opciones del menú principal
op_theme="  Change Theme"
op_wallpaper="󰸉  Change Wallpaper"
op_waybar="󱔓  Change Waybar"
# Mostrar el menú principal
options="$op_theme\n$op_wallpaper\n$op_waybar"

chosen=$(echo -e "$options" | rofi -dmenu -i -p "Appearance:" -show-icons -theme ~/.config/rofi/basic_menu.rasi)

case $chosen in
    $op_theme)
        # Llamamos al submenú de temas
        bash ~/.config/hypr/scripts/theme_selector.sh
        ;;
    $op_wallpaper)
        bash ~/.config/hypr/scripts/wallpaper_selector.sh
    	;;
    $op_waybar)
        bash ~/.config/hypr/scripts/waybar_selector.sh
        ;;
esac
