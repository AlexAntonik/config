#!/usr/bin/env bash

set -euo pipefail

# Always work from the user's home directory
cd "$HOME" || exit 1

if [ -n "$(grep -i nixos </etc/os-release 2>/dev/null)" ]; then
    echo "Verified this is NixOS."
    echo "-----"
else
    echo "This is not NixOS or the distribution information is not available."
    exit 1
fi

if command -v git &>/dev/null; then
    echo "Git is installed, continuing with installation."
else
    echo "Git is not installed. Please install Git and try again."
    echo "Example: nix-shell -p git"
    exit 1
fi

echo "-----"

if [ ! -f "$HOME/.nixos-hostname" ]; then
    echo "Default options are in brackets []"
    echo "Just press enter to select the default"
    sleep 2
    echo "-----"
    read -rp "Enter your new hostname: [ default ] " hostName
    if [ -z "$hostName" ]; then
        hostName="default"
    fi
    echo "$hostName" >"$HOME/.nixos-hostname"
else
    hostName=$(cat "$HOME/.nixos-hostname")
fi

echo "Using hostname: $hostName"
echo "-----"

if [ ! -d "$HOME/config" ]; then
    echo "Cloning & Entering OS Repository"
    
    if ! git clone https://github.com/AlexAntonik/config.git; then
        echo "Failed to clone repository"
        exit 1
    fi
    
    cd config || exit 1
    
    if ! mkdir -p hosts/"$hostName"; then
        echo "Failed to create host directory"
        exit 1
    fi
    
    if ! cp hosts/default/*.nix hosts/"$hostName"/; then
        echo "Failed to copy configuration files"
        exit 1
    fi
    
    installusername="$USER"
    echo "Using username: $installusername"
    
    git config --global user.name "$installusername" || echo "Warning: failed to set git user.name"
    git config --global user.email "$installusername@gmail.com" || echo "Warning: failed to set git user.email"
    
    git add . || echo "Warning: git add failed"
    
    git config --global --unset-all user.name 2>/dev/null || true
    git config --global --unset-all user.email 2>/dev/null || true
    
    echo "Updating flake.nix with hostname and username..."
    if ! sed -i "/^\s*host[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$hostName\"/" ./flake.nix; then
        echo "Warning: failed to update hostname in flake.nix"
    fi
    echo "-----"
    
    if ! sed -i "/^\s*username[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$installusername\"/" ./flake.nix; then
        echo "Warning: failed to update username in flake.nix"
    fi
    echo "-----"
    
    echo "Generating The Hardware Configuration"
    if ! sudo nixos-generate-config --show-hardware-config > "./hosts/$hostName/hardware.nix"; then
        echo "Failed to generate hardware configuration"
        exit 1
    fi
    echo "-----"
    
    echo "Setting Required Nix Settings"
    export NIX_CONFIG="experimental-features = nix-command flakes"
    echo "-----"
else
    echo "Config directory already exists, entering..."
    cd "$HOME/config" || exit 1
fi

echo "Before continuing installation, you must configure drivers."
echo "Please open $HOME/config/hosts/$hostName/drivers.nix and follow the instructions inside the file."

while true; do
    read -rp "Have you already configured drivers in $HOME/config/hosts/$hostName/drivers.nix? (y/n): " drivers_ready
    case $drivers_ready in
        [Yy]* ) 
            echo "Proceeding with installation..."
            break
            ;;
        [Nn]* ) 
            echo "Please configure drivers before continuing installation."
            echo "Opening the drivers.nix file location: $HOME/config/hosts/$hostName/drivers.nix"
            sleep 2
            vim "$HOME/config/hosts/$hostName/drivers.nix" || nano "$HOME/config/hosts/$hostName/drivers.nix"
            exit 0
            ;;
        * ) 
            echo "Please answer yes (y) or no (n)."
            ;;
    esac
done

echo "Starting NixOS rebuild..."
echo "This may take a while..."

if sudo nixos-rebuild switch --flake ~/config/#"${hostName}"; then
    echo "-----"
    echo "Installation completed successfully!"
    echo "You may need to reboot to apply all changes."
else
    echo "-----"
    echo "Installation failed. Please check the error messages above."
    exit 1
fi