#!/bin/bash

# Set strict error handling
set -euo pipefail
IFS=$'\n\t'

# Constants
readonly NVIM_CONFIG_DIR="$HOME/.config/nvim"
readonly BACKUP_DIR="$HOME/nvim_backup"
readonly LOG_FILE="/tmp/nvim_uninstall_$(date +%s).log"

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
    error_log "Uninstallation failed. Check the log file at: $LOG_FILE"
    exit 1
}

# Function to remove source-installed Neovim
remove_neovim() {
    log "Removing Neovim installed from source..."
    
    # Common installation locations for source builds
    local install_locations=(
        "/usr/local/bin/nvim"
        "/usr/local/share/nvim"
        "/usr/local/lib/nvim"
        "/usr/local/include/nvim"
        "/usr/local/share/man/man1/nvim.1"
    )
    
    # Remove Neovim executable and related files
    for location in "${install_locations[@]}"; do
        if [ -e "$location" ]; then
            sudo rm -rf "$location" || log "${YELLOW}Failed to remove: $location${NC}"
            log "Removed: $location"
        fi
    done
    
    # Remove any symlinks
    sudo find /usr/local/bin -lname '*nvim*' -delete 2>/dev/null || true
    
    # Update shared library cache
    sudo ldconfig 2>/dev/null || true
}

# Function to remove Neovim configuration
remove_config() {
    log "Removing Neovim configuration..."
    
    if [ -d "$NVIM_CONFIG_DIR" ]; then
        # Create one final backup before removal
        local final_backup_dir="$BACKUP_DIR/backup_before_uninstall_$(date +%Y%m%d_%H%M%S)"
        log "Creating final backup at: $final_backup_dir"
        mkdir -p "$final_backup_dir" || error_exit "Failed to create final backup directory"
        cp -r "$NVIM_CONFIG_DIR" "$final_backup_dir/" || error_exit "Failed to create final backup"
        
        # Remove the configuration
        rm -rf "$NVIM_CONFIG_DIR" || error_exit "Failed to remove Neovim configuration"
        log "Neovim configuration removed successfully"
    else
        log "${YELLOW}No Neovim configuration found at $NVIM_CONFIG_DIR${NC}"
    fi
    
    # Remove additional Neovim-related directories
    rm -rf "$HOME/.local/share/nvim" 2>/dev/null || true
    rm -rf "$HOME/.local/state/nvim" 2>/dev/null || true
    rm -rf "$HOME/.cache/nvim" 2>/dev/null || true
}

# Function to remove dependencies (if they were installed specifically for Neovim)
remove_dependencies() {
    log "${YELLOW}Note: Dependencies (ripgrep, xsel) were not removed as they might be used by other applications.${NC}"
    log "${YELLOW}If you wish to remove them, please do so manually.${NC}"
}

# Main uninstallation process
main() {
    log "Starting uninstallation..."
    
    # Confirm uninstallation
    echo -e "${YELLOW}Warning: This will remove Neovim (installed from source) and all its configurations.${NC}"
    echo -e "A backup will be created at: $BACKUP_DIR/backup_before_uninstall_$(date +%Y%m%d_%H%M%S)"
    echo -e "The fonts will be preserved."
    read -p "Do you want to continue? (y/N) " -n 1 -r
    echo
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log "Uninstallation cancelled by user"
        exit 0
    fi
    
    # Perform uninstallation steps
    remove_neovim
    remove_config
    remove_dependencies
    
    log "${GREEN}Uninstallation completed successfully!${NC}"
    log "Neovim and its configuration have been removed"
    log "MartianMono fonts have been preserved"
    log "A backup of your configuration was created in the backup directory"
    
    # Final note about verifying removal
    log "${YELLOW}Note: If Neovim was installed in a different location, you may need to remove it manually.${NC}"
    log "${YELLOW}You can verify if nvim is still present by running: 'which nvim'${NC}"
}

# Execute main function
main "$@"
