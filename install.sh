#!/usr/bin/env bash

if [ -n "$(grep -i nixos < /etc/os-release)" ]; then
  echo "Verified this is NixOS."
  echo "-----"
else
  echo "This is not NixOS or the distribution information is not available."
  exit
fi

if command -v git &> /dev/null; then
  echo "Git is installed, continuing with installation."
  echo "-----"
else
  echo "Git is not installed. Please install Git and try again."
  echo "Example: nix-shell -p git"
  exit
fi

echo "Before continuing installation, you must configure drivers."
echo "Please open ./hosts/default/drivers.nix and follow the instructions inside the file."
read -rp "Have you already configured drivers in ./hosts/default/drivers.nix? (y/n): " drivers_ready
if [[ "$drivers_ready" != "y" && "$drivers_ready" != "Y" ]]; then
  echo "Please configure drivers before continuing installation."
  exit
fi

echo "-----"

echo "Default options are in brackets []"
echo "Just press enter to select the default"
sleep 2

echo "-----"

echo "Ensure In Home Directory"
cd || exit

echo "-----"

read -rp "Enter your new hostname: [ default ] " hostName
if [ -z "$hostName" ]; then
  hostName="default"
fi

echo "-----"

backupname=$(date "+%Y-%m-%d-%H-%M-%S")
if [ -d "config" ]; then
  echo "Config exists, backing up to .config/backups folder."
  if [ -d ".config/backups" ]; then
    echo "Moving current version of OS to backups folder."
    mv "$HOME"/config .config/backups/"$backupname"
    sleep 1
  else
    echo "Creating the backups folder & moving OS to it."
    mkdir -p .config/backups
    mv "$HOME"/config .config/backups/"$backupname"
    sleep 1
  fi
fi

echo "-----"

echo "Cloning & Entering OS Repository"
git clone https://github.com/AlexAntonik/config.git
cd config || exit
mkdir hosts/"$hostName"
cp hosts/default/*.nix hosts/"$hostName"
installusername=$(echo $USER)
git config --global user.name "$installusername"
git config --global user.email "$installusername@gmail.com"
git add .
git config --global --unset-all user.name
git config --global --unset-all user.email
sed -i "/^\s*host[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$hostName\"/" ./flake.nix

echo "-----"

sed -i "/^\s*username[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$installusername\"/" ./flake.nix

echo "-----"

echo "Generating The Hardware Configuration"
sudo nixos-generate-config --show-hardware-config > ./hosts/$hostName/hardware.nix

echo "-----"

echo "Setting Required Nix Settings Then Going To Install"
NIX_CONFIG="experimental-features = nix-command flakes"

echo "-----"

sudo nixos-rebuild switch --flake ~/config/#${hostName}
