# #!/bin/bash
#
# # Constants
# REPO_URL="https://github.com/herschel21/nvim-configuration/archive/refs/heads/main.zip"
# TEMP_DIR="temp_files/"
# DEST_DIR="$HOME/.config/"
# ZIP_FILE="$TEMP_DIR/main.zip"
# BACKUP_DIR="$HOME/nvim_backup"
# FONT_DIR="$HOME/.local/share/fonts/"
# FONT_ZIP="MartianMono.zip"
# FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/$FONT_ZIP"
#
# # Ensure necessary directories exist
# mkdir -p "$TEMP_DIR" "$FONT_DIR" "$BACKUP_DIR"
#
# # Function to handle errors
# error_exit() {
#     echo "Error: $1"
#     exit 1
# }
#
# # Install MartianMono fonts
# echo "Installing MartianMono fonts..."
# curl -L "$FONT_URL" -o "$TEMP_DIR/$FONT_ZIP" || error_exit "Failed to download font."
# unzip "$TEMP_DIR/$FONT_ZIP" -d "$FONT_DIR" || error_exit "Failed to unzip font."
# fc-cache -f -v "$FONT_DIR" || error_exit "Failed to refresh font cache."
#
# # Install dependencies based on the OS
# if [ -f "/etc/debian_version" ]; then
#     echo "Installing dependencies for Ubuntu/Debian..."
#     sudo apt-get update
#     sudo apt-get install -y ripgrep xsel || error_exit "Failed to install dependencies."
# elif [ -f "/etc/arch-release" ]; then
#     echo "Installing dependencies for Arch Linux..."
#     sudo pacman -Sy --noconfirm ripgrep xsel || error_exit "Failed to install dependencies."
# else
#     echo "Unsupported OS. Please install 'ripgrep' and 'xsel' manually."
# fi
#
# # Backup existing Neovim configuration
# if [ -d "$DEST_DIR/nvim" ]; then
#     echo "Backing up existing Neovim configuration..."
#     mv "$DEST_DIR/nvim" "$BACKUP_DIR" || error_exit "Failed to back up Neovim configuration."
# fi
#
# # Download and extract dotfiles
# echo "Downloading Neovim configuration..."
# curl -L "$REPO_URL" -o "$ZIP_FILE" || error_exit "Failed to download configuration."
#
# echo "Unzipping configuration..."
# unzip "$ZIP_FILE" -d "$TEMP_DIR" || error_exit "Failed to unzip configuration."
#
# # Copy configuration to the destination
# echo "Installing Neovim configuration..."
# cp -r "$TEMP_DIR/nvim-configuration-main/nvim/" "$DEST_DIR" || error_exit "Failed to copy configuration."
#
# # Clean up temporary files
# echo "Cleaning up..."
# rm -rf "$TEMP_DIR" "$ZIP_FILE"
#
# echo "Installation completed successfully!"

#!/bin/bash

# Set strict error handling
set -euo pipefail
IFS=$'\n\t'

# Constants
readonly REPO_URL="https://github.com/herschel21/nvim-configuration/archive/refs/heads/main.zip"
readonly TEMP_DIR="/tmp/nvim_install_$(date +%s)"
readonly DEST_DIR="$HOME/.config"
readonly ZIP_FILE="$TEMP_DIR/main.zip"
readonly BACKUP_DIR="$HOME/nvim_backup/backup_$(date +%Y%m%d_%H%M%S)"
readonly FONT_DIR="$HOME/.local/share/fonts"
readonly FONT_ZIP="MartianMono.zip"
readonly FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/$FONT_ZIP"
readonly LOG_FILE="$TEMP_DIR/install.log"

# Color constants
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m' # No Color

# Function to log messages
log() {
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo -e "${timestamp} - ${message}" | tee -a "$LOG_FILE"
}

# Function to log errors
error_log() {
    log "${RED}ERROR: $1${NC}"
}

# Function to handle errors
error_exit() {
    error_log "$1"
    error_log "Installation failed. Check the log file at: $LOG_FILE"
    exit 1
}

# Function to check command availability
check_command() {
    if ! command -v "$1" &>/dev/null; then
        error_exit "Required command '$1' not found. Please install it first."
    fi
}

# Function to check required disk space (need at least 500MB free)
check_disk_space() {
    local required_space=500000
    local available_space=$(df "$HOME" | awk 'NR==2 {print $4}')
    
    if [ "$available_space" -lt "$required_space" ]; then
        error_exit "Insufficient disk space. Need at least 500MB free."
    fi
}

# Function to install system dependencies
install_dependencies() {
    log "Installing system dependencies..."
    
    if [ -f "/etc/debian_version" ]; then
        log "Detected Debian/Ubuntu system"
        sudo apt-get update || error_exit "Failed to update package list"
        sudo apt-get install -y ripgrep xsel neovim curl unzip || error_exit "Failed to install dependencies"
    elif [ -f "/etc/arch-release" ]; then
        log "Detected Arch Linux system"
        sudo pacman -Sy --noconfirm ripgrep xsel neovim curl unzip || error_exit "Failed to install dependencies"
    elif [ -f "/etc/fedora-release" ]; then
        log "Detected Fedora system"
        sudo dnf install -y ripgrep xsel neovim curl unzip || error_exit "Failed to install dependencies"
    else
        log "${YELLOW}Unsupported OS. Please install 'ripgrep', 'xsel', 'neovim', 'curl', and 'unzip' manually.${NC}"
        # Continue anyway as the user might have installed dependencies manually
    fi
}

# Function to install fonts
install_fonts() {
    log "Installing MartianMono fonts..."
    mkdir -p "$FONT_DIR" || error_exit "Failed to create font directory"
    
    curl -L "$FONT_URL" -o "$TEMP_DIR/$FONT_ZIP" || error_exit "Failed to download font"
    unzip -o "$TEMP_DIR/$FONT_ZIP" -d "$FONT_DIR" || error_exit "Failed to unzip font"
    fc-cache -f -v "$FONT_DIR" || error_exit "Failed to refresh font cache"
    
    log "Fonts installed successfully"
}

# Function to backup existing configuration
backup_config() {
    if [ -d "$DEST_DIR/nvim" ]; then
        log "Backing up existing Neovim configuration..."
        mkdir -p "$BACKUP_DIR" || error_exit "Failed to create backup directory"
        mv "$DEST_DIR/nvim" "$BACKUP_DIR/" || error_exit "Failed to backup existing configuration"
        log "Backup created at: $BACKUP_DIR"
    fi
}

# Function to install Neovim configuration
install_config() {
    log "Downloading Neovim configuration..."
    curl -L "$REPO_URL" -o "$ZIP_FILE" || error_exit "Failed to download configuration"
    
    log "Extracting configuration..."
    unzip -o "$ZIP_FILE" -d "$TEMP_DIR" || error_exit "Failed to unzip configuration"
    
    log "Installing configuration..."
    mkdir -p "$DEST_DIR" || error_exit "Failed to create config directory"
    cp -r "$TEMP_DIR/nvim-configuration-main/nvim/" "$DEST_DIR/" || error_exit "Failed to copy configuration"
}

# Main installation process
main() {
    # Create temporary directory and start logging
    mkdir -p "$TEMP_DIR" || error_exit "Failed to create temporary directory"
    log "Starting installation..."
    
    # Check prerequisites
    check_command curl
    check_command unzip
    check_command nvim
    check_disk_space
    
    # Perform installation steps
    install_dependencies
    install_fonts
    backup_config
    install_config
    
    # Cleanup
    log "Cleaning up temporary files..."
    rm -rf "$TEMP_DIR"
    
    log "${GREEN}Installation completed successfully!${NC}"
    log "Neovim configuration has been installed to: $DEST_DIR/nvim"
    [ -d "$BACKUP_DIR" ] && log "Your previous configuration was backed up to: $BACKUP_DIR"
}

# Execute main function
main "$@"
