#!/usr/bin/env bash

set -euo pipefail

# Allow hostname to be passed as argument
hostName="${1:-}"

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
if [ -z "$hostName" ]; then
  echo -e "${CYAN}============================================================${NC}"
  echo -e "${CYAN}Please enter a hostname for this machine.${NC}"
  echo -e "${CYAN}It will be used to generate config files for NixOS.${NC}"
  echo -e "${CYAN}If unsure, press Enter to use the default hostname: ${YELLOW}default${NC}"
  echo -e "${CYAN}============================================================${NC}"
  echo

  read -e -p "$(echo -e "${QUESTION}Hostname: ${NC}")" hostName
  hostName="${hostName:-default}"

  echo
  echo -e "${CYAN}Using hostname: ${GREEN}$hostName${NC}"
  echo
else
  echo -e "${CYAN}Using hostname from command-line argument: ${GREEN}$hostName${NC}"
fi

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

    echo -e "${CYAN}Updating env.nix with hostname and username...${NC}"
    if ! sed -i "/^\s*host[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$hostName\"/" ./hosts/"$hostName"/env.nix; then
        echo -e "${RED}Warning: failed to update hostname in env.nix${NC}"
    fi
    echo
    if ! sed -i "/^\s*username[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$installusername\"/" ./hosts/"$hostName"/env.nix; then
        echo -e "${RED}Warning: failed to update username in env.nix${NC}"
    fi
    echo
    echo -e "${CYAN}Generating The Hardware Configuration${NC}"
    if ! sudo nixos-generate-config --show-hardware-config | sudo tee "./hosts/$hostName/hw.nix" > /dev/null; then
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

    if [ ! -d "hosts/$hostName" ]; then
    echo -e "${CYAN}Creating host directory for: $hostName${NC}"
    if ! mkdir -p "hosts/$hostName"; then
        echo -e "${RED}Failed to create host directory${NC}"
        exit 1
    fi
    if ! cp hosts/default/*.nix hosts/"$hostName"/; then
        echo -e "${RED}Failed to copy configuration files from default${NC}"
        exit 1
    fi

    installusername="$USER"
    echo -e "${CYAN}Using username: $installusername${NC}"
    echo

    echo -e "${CYAN}Updating env.nix with hostname and username...${NC}"
    if ! sed -i "/^\s*host[[:space:]]*=[[:space:]]*\"/s/\".*\"/\"$hostName\"/" ./hosts/"$hostName"/env.nix; then
        echo -e "${RED}Warning: failed to update hostname in env.nix${NC}"
    fi
    if ! sed -i "/^\s*username[[:space:]]*=[[:space:]]*\"/s/\".*\"/\"$installusername\"/" ./hosts/"$hostName"/env.nix; then
        echo -e "${RED}Warning: failed to update username in env.nix${NC}"
    fi

    echo
    echo -e "${CYAN}Generating The Hardware Configuration${NC}"
    if ! sudo nixos-generate-config --show-hardware-config | sudo tee "./hosts/$hostName/hardware.nix" > /dev/null; then
        echo -e "${RED}Failed to generate hardware configuration${NC}"
        exit 1
    fi
    echo
fi

fi

echo -e "${YELLOW}============================================================${NC}"
echo -e "${YELLOW}Before continuing installation, you must configure hardware.${NC}"
echo -e "${YELLOW}Please open $HOME/config/hosts/$hostName/hardware.nix${NC}"
echo -e "${YELLOW}and follow the instructions inside the file.${NC}."
echo -e "${YELLOW}============================================================${NC}"
echo
sleep 1

while true; do
    read -e -p "$(echo -e "${QUESTION}Have you already configured hardware in $HOME/config/hosts/$hostName/hardware.nix? (y/n): ${NC}")" drivers_ready
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
            echo -e "${YELLOW}Please configure hardware before continuing installation.${NC}"
            echo
            echo -e "${CYAN}Opening the hardware.nix file location: $HOME/config/hosts/$hostName/hardware.nix${NC}"
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
            vim "$HOME/config/hosts/$hostName/hardware.nix" || nano "$HOME/config/hosts/$hostName/hardware.nix"
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