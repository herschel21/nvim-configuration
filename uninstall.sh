#!/bin/bash

DEST_DIR="$HOME/.config/"
BACKUP_DIR="$HOME/nvim_backup"

echo "Uninstalling Neovim configuration..."

# Check if the backup exists
if [ -d "$BACKUP_DIR" ]; then
    echo "Restoring original Neovim configuration..."
    mv "$BACKUP_DIR" "$DEST_DIR/nvim"
else
    echo "No backup found. Removing custom configuration..."
    rm -rf "$DEST_DIR/nvim"
fi

rm -rf $HOME/.config/nvim/nvim_backup

echo "Uninstallation completed!"

