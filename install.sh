#!/bin/bash

# Constants
REPO_URL="https://github.com/herschel21/nvim-configuration/archive/refs/heads/main.zip"
TEMP_DIR="temp_files/"
DEST_DIR="$HOME/.config/"
ZIP_FILE="$TEMP_DIR/main.zip"
BACKUP_DIR="$HOME/nvim_backup"
FONT_DIR="$HOME/.local/share/fonts/"
FONT_ZIP="MartianMono.zip"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/$FONT_ZIP"

# Ensure necessary directories exist
mkdir -p "$TEMP_DIR" "$FONT_DIR" "$BACKUP_DIR"

# Function to handle errors
error_exit() {
    echo "Error: $1"
    exit 1
}

# Install MartianMono fonts
echo "Installing MartianMono fonts..."
curl -L "$FONT_URL" -o "$TEMP_DIR/$FONT_ZIP" || error_exit "Failed to download font."
unzip "$TEMP_DIR/$FONT_ZIP" -d "$FONT_DIR" || error_exit "Failed to unzip font."
fc-cache -f -v "$FONT_DIR" || error_exit "Failed to refresh font cache."

# Install dependencies based on the OS
if [ -f "/etc/debian_version" ]; then
    echo "Installing dependencies for Ubuntu/Debian..."
    sudo apt-get update
    sudo apt-get install -y ripgrep xsel || error_exit "Failed to install dependencies."
elif [ -f "/etc/arch-release" ]; then
    echo "Installing dependencies for Arch Linux..."
    sudo pacman -Sy --noconfirm ripgrep xsel || error_exit "Failed to install dependencies."
else
    echo "Unsupported OS. Please install 'ripgrep' and 'xsel' manually."
fi

# Backup existing Neovim configuration
if [ -d "$DEST_DIR/nvim" ]; then
    echo "Backing up existing Neovim configuration..."
    mv "$DEST_DIR/nvim" "$BACKUP_DIR" || error_exit "Failed to back up Neovim configuration."
fi

# Download and extract dotfiles
echo "Downloading Neovim configuration..."
curl -L "$REPO_URL" -o "$ZIP_FILE" || error_exit "Failed to download configuration."

echo "Unzipping configuration..."
unzip "$ZIP_FILE" -d "$TEMP_DIR" || error_exit "Failed to unzip configuration."

# Copy configuration to the destination
echo "Installing Neovim configuration..."
cp -r "$TEMP_DIR/nvim-configuration-main/nvim/" "$DEST_DIR" || error_exit "Failed to copy configuration."

# Clean up temporary files
echo "Cleaning up..."
rm -rf "$TEMP_DIR" "$ZIP_FILE"

echo "Installation completed successfully!"

