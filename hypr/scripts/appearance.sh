#!/bin/bash

# Opciones del menú principal
op_theme=" Change Theme"
op_wallpaper="󰸉  Change Wallpaper"

# Mostrar el menú principal
options="$op_theme\n$op_wallpaper"

chosen=$(echo -e "$options" | rofi -dmenu -i -p "Sistema:")

case $chosen in
    $op_theme)
        # Llamamos al submenú de temas
        bash ~/.config/hypr/scripts/theme_selector.sh
        ;;
    $op_wallpaper)
        bash ~/.config/hypr/scripts/wallpaper_selector.sh
    	;;
esac
