#!/bin/bash

REPO_URL="https://github.com/herschel21/dotfiles/archive/refs/heads/main.zip"
DOWNLOAD_DIR="temp_files/"
DEST_DIR="$HOME/.config/"
ZIP_FILE="$DOWNLOAD_DIR/main.zip"
BACKUP_DIR="$HOME/nvim_backup"

#Ensure the backup directory exists
mkdir -p "$BACKUP_DIR"

# Ensure the installation directory exists
mkdir -p "$DOWNLOAD_DIR"

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
cp -r "$DOWNLOAD_DIR"/dotfiles-main/nvim/ "$DEST_DIR"

echo "Cleaning up..."
rm -rf "$DOWNLOAD_DIR" "$ZIP_FILE"

echo "Installation Done!"

