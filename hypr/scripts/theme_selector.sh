#!/bin/bash

# =============================================================================
# DEFINICIÓN DE RUTAS (ORIGEN Y DESTINO)
# =============================================================================

# --- Hyprland ---
HYPR_SRC="$HOME/.config/hypr/themes/colors"
HYPR_LINK="$HOME/.config/hypr/themes/current_theme.conf"

# --- Waybar ---
WAYBAR_SRC="$HOME/.config/waybar/themes"
WAYBAR_LINK="$HOME/.config/waybar/current_theme.css"

# --- Rofi ---
# Tu config.rasi ya importa colors.rasi 
ROFI_SRC="$HOME/.config/rofi/themes"
ROFI_LINK="$HOME/.config/rofi/current_theme.rasi"

# --- Alacritty ---
ALACRITTY_SRC="$HOME/.config/alacritty/themes"
ALACRITTY_LINK="$HOME/.config/alacritty/current_theme.toml"

# --- Ghostty ---
GHOSTTY_SRC="$HOME/.config/ghostty/themes"
GHOSTTY_LINK="$HOME/.config/ghostty/current_theme.conf"

# --- SwayNC ---
SWAYNC_SRC="$HOME/.config/swaync/themes"
SWAYNC_LINK="$HOME/.config/swaync/current_theme.css"

# =============================================================================
# LÓGICA DE SELECCIÓN
# =============================================================================

# Listar los temas disponibles basándose en los archivos .conf de Hyprland
themes=$(ls "$HYPR_SRC" | grep '.conf$' | sed 's/\.conf//')

# Mostrar el menú de Rofi
chosen_theme=$(echo -e "$themes" | rofi -dmenu -i -p "󰈊 Seleccionar Tema:" -theme ~/.config/rofi/basic_menu.rasi)

# Salir si no se selecciona nada
if [ -z "$chosen_theme" ]; then
    exit 0
fi

# Definir el archivo del tema
THEME_FILE="$HYPR_SRC/$chosen_theme.conf"

# =============================================================================
# APLICACIÓN DE CAMBIOS (SYMLINKS)
# =============================================================================

# 1. Aplicar a Hyprland
if [ -f "$HYPR_SRC/$chosen_theme.conf" ]; then
    ln -sf "$HYPR_SRC/$chosen_theme.conf" "$HYPR_LINK"
fi

# 2. Aplicar a Waybar
if [ -f "$WAYBAR_SRC/$chosen_theme.css" ]; then
    ln -sf "$WAYBAR_SRC/$chosen_theme.css" "$WAYBAR_LINK"
fi

# 3. Aplicar a Rofi
if [ -f "$ROFI_SRC/$chosen_theme.rasi" ]; then
    ln -sf "$ROFI_SRC/$chosen_theme.rasi" "$ROFI_LINK"
fi

# 4. Aplicar a Alacritty
if [ -f "$ALACRITTY_SRC/$chosen_theme.toml" ]; then
    ln -sf "$ALACRITTY_SRC/$chosen_theme.toml" "$ALACRITTY_LINK"
fi


# 5. Aplicar a Ghostty
if [ -f "$GHOSTTY_SRC/$chosen_theme.conf" ]; then
    ln -sf "$GHOSTTY_SRC/$chosen_theme.conf" "$GHOSTTY_LINK"
fi

# 6. Aplicar a SwayNC
if [ -f "$SWAYNC_SRC/$chosen_theme.css" ]; then
    ln -sf "$SWAYNC_SRC/$chosen_theme.css" "$SWAYNC_LINK"
fi

swaync-client -rs
# =============================================================================
# LÓGICA DE WALLPAPER POR DEFECTO
# =============================================================================

# Extraer la ruta del wallpaper del archivo .conf
# Busca la línea: $wallpaper = ~/ruta/al/fondo.png
wall_path=$(grep "\$wallpaper =" "$THEME_FILE" | cut -d'=' -f2 | xargs | sed "s|^~|$HOME|")

if [ -n "$wall_path" ] && [ -f "$wall_path" ]; then
    echo "Aplicando wallpaper con awww..."
    awww img "$wall_path" --transition-type center --transition-duration 1 --transition-fps 60
else
    echo "ERROR: No se pudo encontrar la imagen en '$wall_path'"
fi

# =============================================================================
# RECARGA DE COMPONENTES
# =============================================================================

# Recargar Hyprland para aplicar nuevos colores de bordes
hyprctl reload

# Enviar señal USR2 a Waybar para recargar el CSS sin reiniciar el proceso
pkill -USR2 waybar

# Notificación final
notify-send -u low "Sistema" "Tema $chosen_theme aplicado correctamente" -i accessory-character-map
