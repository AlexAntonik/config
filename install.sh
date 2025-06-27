#!/usr/bin/env bash

set -euo pipefail

cd "$HOME" || exit 1

# Color definitions
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
RED='\033[1;31m'
CYAN='\033[1;36m'
QUESTION='\033[1;34m'
NC='\033[0m' # No Color

if [ -n "$(grep -i nixos </etc/os-release 2>/dev/null)" ]; then
    echo
    echo -e "${GREEN}Verified this is NixOS.${NC}"
else
    echo
    echo -e "${RED}This is not NixOS or the distribution information is not available.${NC}"
    exit 1
fi

if command -v git &>/dev/null; then
    echo
    echo -e "${GREEN}Git is installed, continuing with installation.${NC}"
else
    echo
    echo -e "${RED}Git is not installed. Please install Git and try again.${NC}"
    echo "Example: nix-shell -p git"
    exit 1
fi

echo

if [ ! -f "$HOME/.nixos-hostname" ]; then
    echo -e "${CYAN}Default options are in brackets []${NC}"
    echo -e "${CYAN}Just press enter to select the default${NC}"
    sleep 2
    echo "-----"
    echo
    read -e -p "$(echo -e "${QUESTION}Enter your new hostname: [ default ] ${NC}")" hostName
    if [ -z "$hostName" ]; then
        hostName="default"
    fi
    echo "$hostName" >"$HOME/.nixos-hostname"
    echo
else
    hostName=$(cat "$HOME/.nixos-hostname")
fi

echo -e "${CYAN}Using hostname: $hostName${NC}"
echo
sleep 1

if [ ! -d "$HOME/config" ]; then
    echo -e "${CYAN}Cloning & Entering OS Repository${NC}"
    echo
    if ! git clone https://github.com/AlexAntonik/config.git; then
        echo -e "${RED}Failed to clone repository${NC}"
        echo
        exit 1
    fi
    cd config || exit 1
    if ! mkdir -p hosts/"$hostName"; then
        echo -e "${RED}Failed to create host directory${NC}"
        echo
        exit 1
    fi
    if ! cp hosts/default/*.nix hosts/"$hostName"/; then
        echo -e "${RED}Failed to copy configuration files${NC}"
        echo
        exit 1
    fi
    installusername="$USER"
    echo -e "${CYAN}Using username: $installusername${NC}"
    echo
    git config --global user.name "$installusername" || echo -e "${RED}Warning: failed to set git user.name${NC}"
    git config --global user.email "$installusername@gmail.com" || echo -e "${RED}Warning: failed to set git user.email${NC}"
    git add . || echo -e "${RED}Warning: git add failed${NC}"
    git config --global --unset-all user.name 2>/dev/null || true
    git config --global --unset-all user.email 2>/dev/null || true
    echo -e "${CYAN}Updating local.nix with hostname and username...${NC}"
    if ! sed -i "/^\s*host[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$hostName\"/" ./local.nix; then
        echo -e "${RED}Warning: failed to update hostname in local.nix${NC}"
    fi
    echo
    if ! sed -i "/^\s*username[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$installusername\"/" ./local.nix; then
        echo -e "${RED}Warning: failed to update username in local.nix${NC}"
    fi
    echo
    echo -e "${CYAN}Generating The Hardware Configuration${NC}"
    if ! sudo nixos-generate-config --show-hardware-config > "./hosts/$hostName/hardware.nix"; then
        echo -e "${RED}Failed to generate hardware configuration${NC}"
        echo
        exit 1
    fi
    echo
    echo -e "${CYAN}Setting Required Nix Settings${NC}"
    export NIX_CONFIG="experimental-features = nix-command flakes"
    echo
else
    echo -e "${CYAN}Config directory already exists, entering...${NC}"
    echo
    cd "$HOME/config" || exit 1
fi

echo -e "${YELLOW}============================================================${NC}"
echo -e "${YELLOW}Before continuing installation, you must configure drivers.${NC}"
echo -e "${YELLOW}Please open $HOME/config/hosts/$hostName/drivers.nix${NC}"
echo -e "${YELLOW}and follow the instructions inside the file.${NC}."
echo -e "${YELLOW}============================================================${NC}"
echo
sleep 1

while true; do
    read -e -p "$(echo -e "${QUESTION}Have you already configured drivers in $HOME/config/hosts/$hostName/drivers.nix? (y/n): ${NC}")" drivers_ready
    case $drivers_ready in
        [Yy]* ) 
            echo
            echo -e "${GREEN}Proceeding with installation...${NC}"
            echo
            sleep 1
            break
            ;;
        [Nn]* ) 
            echo
            echo -e "${YELLOW}Please configure drivers before continuing installation.${NC}"
            echo
            echo -e "${CYAN}Opening the drivers.nix file location: $HOME/config/hosts/$hostName/drivers.nix${NC}"
            # Spinner for 2 seconds
            spin='-\|/'
            echo -n " "
            for i in {1..16}; do
                i_mod=$((i % 4))
                printf "\b${spin:$i_mod:1}"
                sleep 0.2
            done
            printf "\b"
            echo
            vim "$HOME/config/hosts/$hostName/drivers.nix" || nano "$HOME/config/hosts/$hostName/drivers.nix"
            echo -e "${RED}============================================================${NC}"
            echo -e "${RED}!!! Make sure you saved the file after editing !!!${NC}"
            echo -e "${RED}============================================================${NC}"
            ;;
        * ) 
            echo
            echo -e "${RED}Please answer yes (y) or no (n).${NC}"
            echo
            ;;
    esac
done

echo -e "${CYAN}Starting NixOS rebuild...${NC}"
echo -e "${CYAN}This may take a while...${NC}"
echo
sleep 1

if sudo nixos-rebuild switch --flake ~/config/#"${hostName}"; then
    echo
    echo -e "${GREEN}Installation completed successfully!${NC}"
    echo -e "${CYAN}You may need to reboot to apply all changes.${NC}"
    echo
else
    echo
    echo -e "${RED}Installation failed. Please check the error messages above.${NC}"
    echo
    exit 1
fi