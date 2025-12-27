#!/usr/bin/env bash
set -euo pipefail

# Full path to Zsh
ZSH_PATH=$(which zsh)

# File to modify
USERADD_FILE="/etc/default/useradd"

# Check if the file exists
if [ ! -f "$USERADD_FILE" ]; then
    echo "Error: $USERADD_FILE not found"
    exit 1
fi

# Replace existing SHELL line or add it if missing
if grep -q "^SHELL=" "$USERADD_FILE"; then
    sudo sed -i "s|^SHELL=.*|SHELL=$ZSH_PATH|" "$USERADD_FILE"
else
    echo "SHELL=$ZSH_PATH" | sudo tee -a "$USERADD_FILE" >/dev/null
fi

echo "✅ Default shell in $USERADD_FILE set to $ZSH_PATH"
