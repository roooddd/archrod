#!/bin/bash

#  PATHS 
DOTFILES="$HOME/dotfiles"
CONFIG="$HOME/.config"
THEMES="$HOME/.themes"

#  CORES 
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log()    { echo -e "${GREEN}[update]${NC} $1"; }
warn()   { echo -e "${YELLOW}[warn]${NC} $1"; }
error()  { echo -e "${RED}[erro]${NC} $1"; }

#  VERIFICA SE O REPOSIToRIO EXISTE
if [ ! -d "$DOTFILES/.git" ]; then
    error "Repositirio nao encontrado em $DOTFILES"
    error "Clone o repositorio primeiro: git clone <url> ~/dotfiles"
    exit 1
fi

#  PULL 
log "Buscando atualizacoes do GitHub..."
cd "$DOTFILES" || exit 1

git pull || { error "Falha ao puxar atualizacoes"; exit 1; }

echo ""
log "Distribuindo arquivos..."

mkdir -p "$CONFIG"
mkdir -p "$THEMES"

# detecta monitor e atualiza hyprland.conf
MONITOR=$(hyprctl monitors | awk '/^Monitor/{print $2; exit}')
sed -i "s/^monitor = [^,]*/monitor = $MONITOR/" ~/.config/hypr/hyprland.conf
echo "Monitor detectado: $MONITOR"

# pastas e arquivos do .config
if [ -d "$DOTFILES/.config" ]; then
    rsync -a "$DOTFILES/.config/" "$CONFIG/"
    log ".config (certo)"
else
    warn "Pasta .config nao encontrada no repositorio"
fi

# .zshrc
if [ -f "$DOTFILES/.zshrc" ]; then
    cp "$DOTFILES/.zshrc" "$HOME/.zshrc"
    log ".zshrc (certo)"
else
    warn ".zshrc nao encontrado no repositorio"
fi

# tema adw-gtk3-dark
if [ -d "$DOTFILES/.themes/adw-gtk3-dark" ]; then
    rsync -a "$DOTFILES/.themes/adw-gtk3-dark" "$THEMES/"
    log ".themes/adw-gtk3-dark (certo)"
else
    warn ".themes/adw-gtk3-dark nao encontrado no repositorio"
fi

echo ""
log "Atualizacao concluida!"
