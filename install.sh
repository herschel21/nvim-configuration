#!/bin/bash

REPO_URL="https://github.com/herschel21/dotfiles/archive/refs/heads/main.zip"
DOWNLOAD_DIR="temp_files/"
DEST_DIR="$HOME/.config/"
ZIP_FILE="$DOWNLOAD_DIR/main.zip"
BACKUP_DIR="$HOME/nvim_backup"
FONT_DIR="$HOME/.local/share/fonts/"
FONT_ZIP="MartianMono.zip"

# Ensure the backup directory exists
mkdir -p "$BACKUP_DIR"

# Ensure the installation and font directories exist
mkdir -p "$DOWNLOAD_DIR"
mkdir -p "$FONT_DIR"

# Install MartianMono fonts
echo "Installing MartianMono fonts..."
curl -L "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/$FONT_ZIP" -o "$FONT_ZIP"
unzip "$FONT_ZIP" -d "$FONT_DIR"
fc-cache -f -v "$FONT_DIR"
sudo apt-get install ripgrep -y
sudo apt-get install xsel -y

# Backup existing Neovim configuration if it exists
if [ -d "$DEST_DIR/nvim" ]; then
    echo "Backing up existing Neovim configuration..."
    mv "$DEST_DIR/nvim" "$BACKUP_DIR"
fi

echo "Downloading dotfile..."
curl -L "$REPO_URL" -o "$ZIP_FILE"

echo "Unzipping the dotfile..."
unzip "$ZIP_FILE" -d "$DOWNLOAD_DIR"

echo "Copying..."
cp -r "$DOWNLOAD_DIR/dotfiles-main/nvim/" "$DEST_DIR"

echo "Cleaning up..."
rm -rf "$DOWNLOAD_DIR" "$ZIP_FILE" "$FONT_ZIP"

echo "Installation Done!"
