# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# npm global binaries
export PATH=~/.npm-global/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# BT control (coexistence WiFi/BT)
alias bt-on='bt-ctl on'
alias bt-off='bt-ctl off'
alias bt-status='bt-ctl status'
alias wget-wall='~/.local/bin/wallhaven-download'
alias waypaper='waypaper-gnome'
alias waypaper-refresh='waypaper-refresh'
alias wallhaven-download='wallhaven-download'
alias wallpaper-brain='wallpaper-brain'
alias wp-push='~/projects/waypaper-my-version/git-push.sh'
alias wp-repo='cd ~/projects/waypaper-my-version/'

# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"
