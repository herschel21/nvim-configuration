!#/bin/bash

DEST_DIR="$HOME/.config/nvim"
BACKUP_DIR="$HOME/nvim_backup/"

echo "Uninstalling Neovim configuration..."

# Check if the backup exists
if [ -d "$BACKUP_DIR" ]; then
    echo "Removing existing Neovim configuration..."
    rm -rf "$DEST_DIR"  # Remove the current Neovim configuration

    echo "Restoring original Neovim configuration..."
    mv "$BACKUP_DIR/nvim" "$DEST_DIR"  # Restore from backup
else
    echo "No backup found. Removing custom configuration..."
    rm -rf "$DEST_DIR"  # Just remove the custom configuration if no backup exists
fi



echo "Uninstallation completed!"
