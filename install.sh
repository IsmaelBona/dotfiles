#!/bin/bash

# --- Colores ---
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Iniciando instalación de Dotfiles...${NC}\n"

# 1. Instalar yay si no existe
if ! command -v yay &> /dev/null; then
    echo -e "${GREEN}Instalando yay (AUR helper)...${NC}"
    sudo pacman -S --needed base-devel git
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
else
    echo -e "${BLUE}Yay ya está instalado. Saltando...${NC}"
fi

# 2. Instalar paquetes de repositorios oficiales y AUR
echo -e "${GREEN}Instalando programas con yay...${NC}"

# 3. Instalación masiva desde pkglist
echo -e "${GREEN}Instalando paquetes desde $PKGS_FILE...${NC}"
yay -S --needed --noconfirm - < "$PKGS_FILE"

yay -S --needed \
    hyprland waybar swaybg rofi-wayland \
    alacritty ghostty yazi qbittorrent btop htop \
    vim neovim mpv mpv-mpris calibre ghostwriter brave-bin \
    zen-browser-bin stow flatpak

# 3. Configurar Flatpak e instalar apps
echo -e "${GREEN}Instalando aplicaciones Flatpak...${NC}"
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install -y flathub \
    md.obsidian.Obsidian \
    com.obsproject.Studio \
    org.prismlauncher.PrismLauncher \
    io.dbeaver.DBeaverCommunity \
    org.kde.krita \
    com.spotify.Client \
    io.freetubeapp.FreeTube \
    com.discordapp.Discord

# 4. Gestión de Dotfiles con GNU Stow
echo -e "${GREEN}Aplicando configuraciones (Stow)...${NC}"
# Esto asume que el script se ejecuta desde la carpeta ~/dotfiles
stow .

echo -e "${BLUE}\n¡Todo listo! Ya puedes iniciar Hyprland.${NC}"
