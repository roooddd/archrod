#!/bin/bash

#  PATHS 
DOTFILES="$HOME/dotfiles"
CONFIG="$HOME/.config"
THEMES="$HOME/.themes"

#  CORES 
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

log()    { echo -e "${GREEN}[update]${NC} $1"; }
warn()   { echo -e "${YELLOW}[warn]${NC} $1"; }
error()  { echo -e "${RED}[erro]${NC} $1"; }
info()   { echo -e "${BLUE}[info]${NC} $1"; }

#  VERIFICA SE O REPOSIToRIO EXISTE 
if [ ! -d "$DOTFILES/.git" ]; then
    error "Repositorio nao encontrado em $DOTFILES"
    error "Clone o repositorio primeiro: git clone <url> ~/dotfiles"
    exit 1
fi

cd "$DOTFILES" || exit 1

#  VERIFICA SE TEM MUDANcAS LOCAIS NaO ENVIADAS 
git fetch origin main --quiet

LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse origin/main)

if [ -n "$(git status --porcelain)" ]; then
    warn "Voce tem mudancas locais nao enviadas para o GitHub!"
    warn "Se continuar, essas mudancas podem ser sobrescritas."
    echo ""
    read -p "Deseja continuar mesmo assim? (s/N): " confirm
    if [[ "$confirm" != "s" && "$confirm" != "S" ]]; then
        info "Cancelado. Rode sync-dots primeiro para enviar suas mudancas."
        exit 0
    fi
    
    # guarda as mudancas locais antes de puxar
    git stash --quiet
    info "Mudancas locais guardadas temporariamente"
fi

#  PULL 
if [ "$LOCAL" = "$REMOTE" ]; then
    info "Ja esta atualizado com o GitHub"
else
    log "Buscando atualizacoes do GitHub..."
    git pull || { error "Falha ao puxar atualizacoes"; exit 1; }
    log "GitHub atualizado"
fi

# reaplica mudancas locais se foram guardadas
if git stash list | grep -q "stash@{0}"; then
    git stash pop --quiet
    
    if git status | grep -q "both modified\|Unmerged"; then
        warn "Conflitos detectados! Abrindo VSCode para resolver..."
        code "$DOTFILES"
        echo ""
        error "Resolva os conflitos no VSCode e depois rode:"
        error "  cd ~/dotfiles && git add . && git commit -m 'merge' && git push"
        exit 1
    fi
fi

echo ""
log "Distribuindo arquivos..."

mkdir -p "$CONFIG"
mkdir -p "$THEMES"

# pastas e arquivos do .config
if [ -d "$DOTFILES/.config" ]; then
    rsync -a "$DOTFILES/.config/" "$CONFIG/"
    log ".config (certo)"
else
    warn "Pasta .config nao encontrada no repositorio"
fi

# detecta monitor e atualiza hyprland.lua DEPOIS do rsync
MONITOR=$(hyprctl monitors | awk '/^Monitor/{print $2; exit}')
RATE=$(hyprctl monitors -j | python3 -c "import json,sys; m=json.load(sys.stdin)[0]; print(int(m['refreshRate']))")
sed -i "s/output\s*=\s*\"[^\"]*\"/output   = \"$MONITOR\"/" ~/.config/hypr/modules/monitors.lua
sed -i "s/mode\s*=\s*\"[^x]*x[^@]*@[^\"]*\"/mode     = \"1920x1080@$RATE\"/" ~/.config/hypr/modules/monitors.lua
log "Monitor detectado: $MONITOR @ ${RATE}Hz"

# aplica matugen com o wallpaper atual
WALLPAPER=$(readlink -f "$HOME/.cache/last_wallpaper")
if [ -f "$WALLPAPER" ]; then
    matugen image "$WALLPAPER" -m "dark" --source-color-index 0
    log "Matugen aplicado (certo)"
else
    warn "Wallpaper nao encontrado em ~/.cache/last_wallpaper, pulando matugen..."
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