#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/anthra123x/dev-env-config.git"
REPO_DIR="$HOME/dev-env-config"
BACKUP_DIR="$HOME/dev-env-backup-$(date +%Y%m%d-%H%M%S)"

BOLD='\033[1m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

info()  { echo -e "${CYAN}::${NC} $1"; }
ok()    { echo -e "${GREEN}✓${NC} $1"; }
warn()  { echo -e "${YELLOW}⚠${NC} $1"; }

echo -e "${BOLD}"
echo "╔══════════════════════════════════════╗"
echo "║     Development Environment Setup    ║"
echo "╚══════════════════════════════════════╝"
echo -e "${NC}"

# ── Clone or update repo ──
if [ -d "$REPO_DIR/.git" ]; then
    info "Updating existing repo..."
    git -C "$REPO_DIR" pull --ff-only
    ok "Repo updated"
else
    info "Cloning repo..."
    git clone "$REPO_URL" "$REPO_DIR"
    ok "Repo cloned to $REPO_DIR"
fi

cd "$REPO_DIR"

# ── Install packages ──
info "Installing packages..."
bash install-packages.sh
ok "Packages installed"

# ── Backup existing dotfiles ──
info "Backing up existing configs to $BACKUP_DIR..."
mkdir -p "$BACKUP_DIR/home"

link_file() {
    local src="$1"
    local dest="$2"
    local dest_dir

    dest_dir=$(dirname "$dest")
    mkdir -p "$dest_dir"

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        local bak="$BACKUP_DIR$(echo "$dest" | sed "s|$HOME||")"
        mkdir -p "$(dirname "$bak")"
        mv "$dest" "$bak"
        warn "Backed up $dest -> $bak"
    fi

    ln -sf "$src" "$dest"
    ok "Linked $src -> $dest"
}

# ── Link home configs ──
info "Creating symlinks..."
find home -type f | while IFS= read -r f; do
    src="$REPO_DIR/$f"
    dest="$HOME/$(echo "$f" | sed 's|^home/||')"
    link_file "$src" "$dest"
done

# ── Apply GNOME settings ──
if [ -f "$REPO_DIR/desktop/gnome-settings.dconf" ]; then
    info "Applying GNOME settings..."
    dconf load /org/gnome/ < "$REPO_DIR/desktop/gnome-settings.dconf" 2>/dev/null || warn "dconf load skipped (not in GNOME?)"
    ok "GNOME settings applied"
fi

# ── Enable systemd user services ──
info "Enabling systemd user services..."
systemctl --user daemon-reload 2>/dev/null || true
for service in bt-auto-off.service wallpaper-brain.service wallpaper-brain.timer wallhaven-fetch.service wallhaven-fetch.timer; do
    systemctl --user enable "$service" 2>/dev/null && ok "Enabled $service" || warn "Could not enable $service"
done

# ── Configure git ──
info "Configuring git..."
git config --global init.defaultBranch main
git config --global pull.rebase true
git config --global core.editor "code --wait"
git config --global core.autocrlf input
git config --global core.eol lf
git config --global diff.algorithm patience
git config --global fetch.prune true
git config --global merge.conflictstyle zdiff3
git config --global push.autoSetupRemote true
git config --global push.followTags true
git config --global rebase.autostash true
git config --global rebase.autosquash true
git config --global status.short true
git config --global branch.sort -committerdate
ok "Git configured (user/email not set — run: git config --global user.name '...' && git config --global user.email '...')"

# ── Done ──
echo ""
echo -e "${BOLD}${GREEN}Setup complete!${NC}"
echo ""
echo "  What was done:"
echo "  ✓ System packages installed"
echo "  ✓ Flatpaks installed"
echo "  ✓ VS Code extensions installed"
echo "  ✓ Config files linked to ~/"
echo "  ✓ GNOME settings restored"
echo "  ✓ Systemd user services enabled"
echo ""
echo "  Next steps:"
echo "  1. Restart your shell or run: source ~/.bashrc"
echo "  2. Authenticate GitHub: gh auth login"
echo "  3. Log out and back in for GNOME settings to take effect"
echo ""
