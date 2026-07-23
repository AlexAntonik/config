{ pkgs, ... }:
{
  host = {
    # Locals
    username = "base";
    hostname = "base"; # Must be the same as dir name(as in quotes - hosts/"base"/)

    # Git Configuration
    gitUsername = "AlexAntonik";
    gitEmail = "antonikavv@gmail.com";

    timeZone = "Europe/Minsk";

    # This value determines the Home Manager/NixOs release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager/NixOs release
    # introduces backwards incompatible changes.
    #
    # You should not change this , even if you update Home Manager/NixOs. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "25.11";
  };

  imports = [
    # Host specific config
    ./hardware.nix
    ./hardware-gen.nix

    # Users
    ./../../modules/users/user-desktop.nix

    # System boot & visuals
    ./../../modules/boot.nix
    ./../../modules/boot-visuals.nix
    ./../../modules/noctalia/noctalia.nix
    ./../../modules/theme.nix
    ./../../modules/hyprland/hyprland.nix
    ./../../modules/fonts.nix

    # Desktop hardware & services
    ./../../modules/desktop/hardware.nix
    ./../../modules/desktop/services.nix
    ./../../modules/desktop/pkgs.nix
    ./../../modules/networking/desktop-network.nix
    ./../../modules/thunar.nix
    ./../../modules/media.nix
    ./../../modules/bluetooth.nix

    # System services
    ./../../modules/logs.nix
    ./../../modules/ssh.nix
    ./../../modules/security.nix
    ./../../modules/home-manager.nix

    # Tools & utilities
    ./../../modules/utilities.nix
    ./../../modules/btop.nix
    ./../../modules/starship.nix
    ./../../modules/fzf.nix
    ./../../modules/yazi.nix
    ./../../modules/bat.nix
    ./../../modules/zoxide.nix

    # Development
    ./../../modules/git.nix
    ./../../modules/direnv.nix
    ./../../modules/lazygit.nix
    ./../../modules/vscode/vscode.nix
    # ./../../modules/docker.nix
    ./../../modules/nvim/nvim-full.nix

    # Applications
    # ./../../modules/steam.nix
    ./../../modules/firefox.nix
    # ./../../modules/obs.nix

    # Config & misc
    ./../../modules/nix.nix
    ./../../modules/time.nix
    ./../../modules/zsh.nix
    # ./../../modules/tailscale.nix
    ./../../modules/ghostty.nix
    ./../../modules/xdg.nix

    # Scripts
    ./../../modules/scripts/syncsupprep.nix
    ./../../modules/scripts/toggleXWaylandScale.nix
  ];

  programs = {
    # amnezia-vpn.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Programming languages
    # go # Go programming language
    # nixd # Nix LSP

    # Development tools
    # meson # Build system
    # ninja # Build system
    unzip # ZIP archive extractor
    # postgresql

    # Desktop suite
    # obsidian # Personal knowledge base

    # Communication & Internet
    # discord # Chat and voice communication

    # Media Creation & Editing
    # audacity # Audio editor

    # Gaming
    # vintagestory
  ];
}
