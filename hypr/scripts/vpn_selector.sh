#!/bin/zsh

# Configuración de Rofi
ROFI_STYLE="-dmenu -p '󰖂 Seleccionar País VPN' -i -show-icons -theme ~/.config/rofi/basic_menu.rasi"

# Definimos los países y sus códigos (Formato: "Icono Nombre;Código")
# Puedes añadir más siguiendo este formato
PAISES=(
    "󰅙⠀Disconnect;DISCONNECT"
    "󰡶⠀España;ES"
    "⠀Suiza;CH"
    "⠀Canadá;CA"
    "󰚅⠀EE.UU.;US"
    "󰼾⠀Francia;FR"
    "󰠳⠀Portugal;PT"
    "⠀Japón;JP"
)

# 1. Creamos la lista para Rofi
LISTA_ROFI=""
for p in "${PAISES[@]}"; do
    LISTA_ROFI+="$(echo $p | cut -d';' -f1)\n"
done

# 2. Mostrar Rofi
SELECCION=$(echo -e "$LISTA_ROFI" | sed '/^$/d' | rofi $ROFI_STYLE)

# 3. Si no elige nada, salir
[ -z "$SELECCION" ] && exit 0

# 4. Obtener el código del país seleccionado
# Buscamos en el array el nombre que coincida con la selección para sacar el código
for p in "${PAISES[@]}"; do
    if [[ "$p" == "$SELECCION"* ]]; then
        CODIGO=$(echo $p | cut -d';' -f2)
        break
    fi
done

# 5. Lógica de ejecución
if [ "$CODIGO" == "DISCONNECT" ]; then
    notify-send "Proton VPN" "Desconectando..." -i network-vpn
    protonvpn disconnect
else
    notify-send "Proton VPN" "Conectando a $SELECCION..." -i network-vpn
    protonvpn connect --country "$CODIGO"
fi
