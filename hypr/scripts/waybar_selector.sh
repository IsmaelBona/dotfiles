#!/bin/bash

# Configuración de rutas
THEMES_DIR="$HOME/.config/waybar/types"
WAYBAR_CONFIG_DIR="$HOME/.config/waybar"

# 1. Obtener la lista de carpetas dentro de themes
if [ ! -d "$THEMES_DIR" ]; then
    notify-send "Error" "La carpeta de temas no existe"
    exit 1
fi

# 2. Usar Rofi para seleccionar el tema
# Listamos solo los nombres de los directorios
SELECTED_THEME=$(ls -d "$THEMES_DIR"/*/ | xargs -n 1 basename | rofi -dmenu -p "Selecciona un tema de Waybar:" -theme ~/.config/rofi/basic_menu.rasi)

# Si el usuario cancela (Esc), salimos
if [ -z "$SELECTED_THEME" ]; then
    exit 0
fi

# 3. Ruta del tema seleccionado
THEME_PATH="$THEMES_DIR/$SELECTED_THEME"

# 4. Copiar archivos (asumiendo que se llaman config.jsonc y style.css)
# Usamos -f para sobrescribir sin preguntar
cp "$THEME_PATH/config" "$WAYBAR_CONFIG_DIR/config"
cp "$THEME_PATH/style.css" "$WAYBAR_CONFIG_DIR/style.css"

# 5. Reiniciar Waybar
killall waybar
waybar &

