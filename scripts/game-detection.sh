#!/usr/bin/env bash
# game-detection.sh — enables GameMode when games are running
# This is a stub — customize detection logic as needed.
set -euo pipefail

GAME_PROCESSES=("stalcraft" "stalzone" "blasphemous" "dyinglight" "mordor" "spacemarine")

while true; do
    game_running=false
    for proc in "${GAME_PROCESSES[@]}"; do
        if pgrep -f "$proc" &>/dev/null; then
            game_running=true
            break
        fi
    done

    if [ "$game_running" = true ]; then
        gamemoderun true 2>/dev/null || true
    fi

    sleep 30
done
