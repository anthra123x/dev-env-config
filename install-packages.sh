#!/usr/bin/env bash
set -euo pipefail

echo "=== Installing system packages (dnf) ==="
sudo dnf group install -y \
    development-tools \
    development-libs \
    multimedia \
    fonts \
    gnome-desktop \
    hardware-support \
    system-tools \
    editors

sudo dnf install -y \
    git \
    gh \
    gamemode \
    mangohud \
    variety \
    fastfetch \
    htop \
    btop \
    pipx \
    git-lfs

echo "=== Installing flatpaks ==="
flatpak install -y flathub \
    com.mattjakeman.ExtensionManager \
    md.obsidian.Obsidian

echo "=== Installing VS Code extensions ==="
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if command -v code &>/dev/null; then
    while IFS= read -r ext; do
        [ -z "$ext" ] && continue
        code --install-extension "$ext" --force
    done < "$REPO_DIR/vscode/extensions.txt"
fi

echo "=== Packages installed ==="
