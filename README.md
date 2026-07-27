# dev-env-config

Configuración de entorno de desarrollo y escritorio — Fedora 44 + GNOME.

## Instalación

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/anthra123x/dev-env-config/main/bootstrap.sh)"
```

## Qué instala

- **Paquetes del sistema:** git, gh, gamemode, mangohud, variety, pipx, git-lfs
- **Flatpaks:** Extension Manager, Obsidian
- **Extensiones de VS Code** (47 extensions)

## Qué configura

- Bash (.bashrc, .bash_profile)
- Git (rebase, zdiff3, autosquash, etc.)
- npm (global prefix)
- Aider (modelo local LM Studio)
- Claude CLI (MCP codebase-memory)
- VS Code (settings.json)
- GTK bookmarks + XDG user dirs (es_ES)
- GNOME settings (tema oscuro, atajos, extensiones)
- GameMode + MangoHud
- Systemd servicios de usuario (bluetooth auto-off, wallpapers)
- Navegador por defecto (Brave)

## Actualizar

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/anthra123x/dev-env-config/main/bootstrap.sh)"
```

## Estructura

```
dev-env-config/
├── bootstrap.sh              # Entry point
├── install-packages.sh       # Instalación de paquetes
├── home/                     # Mirror de ~/ (se enlaza simbólicamente)
│   ├── .bashrc
│   ├── .bash_profile
│   ├── .gitconfig
│   ├── .npmrc
│   ├── .aider.conf.yml
│   ├── .claude.json
│   └── .config/
│       ├── Code/User/settings.json
│       ├── gtk-3.0/bookmarks
│       ├── user-dirs.dirs
│       ├── mimeapps.list
│       ├── autostart/
│       ├── MangoHud/MangoHud.toml
│       ├── gamemode.ini
│       └── systemd/user/
├── desktop/
│   └── gnome-settings.dconf
├── git/
│   └── config.yml
├── vscode/
│   └── extensions.txt
├── dev/
│   └── .claude-settings.json
└── scripts/
    └── game-detection.sh
```
