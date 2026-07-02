{ pkgs, ... }:
{
  host = {
    # Locals
    username = "alex";
    flakePath = "/home/alex/config";
    hostname = "asus"; # Must be the same as dir name

    gitUsername = "AlexAntonik";
    gitEmail = "antonikavv@gmail.com";

    # Devices for some features
    mainMonitor = "eDP-1";
    touchpadID = "asue120b:00-04f3:31c0-touchpad"; # From hyprctl devices
    keyboardLightID = "asus::kbd_backlight"; # From brightnessctl -l
    keyboardScreenOFFLightID = "asus::camera"; # From brightnessctl -l shines when screen and keyboard are off
    languageLightID = "platform::micmute"; # Same used to indicate not en lang

    # Time and Locale Settings
    kbdIdleTimeout = "120"; # In seconds, time before keyboard backlight off
    keyboardLayout = "us,ru";
    timeZone = "Europe/Minsk";
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = "en_US.UTF-8";

    stateVersion = "23.11";
  };

  imports = [
    # Host specific config
    ./hardware.nix
    ./hardware-gen.nix
    ./syncthing.nix
    ./secrets/secrets.nix

    # Users
    ./../../modules/users/desktop-default.nix

    # System boot & visuals
    ./../../modules/boot.nix
    ./../../modules/boot-visuals.nix
    ./../../modules/noctalia/noctalia.nix
    ./../../modules/stylix.nix
    ./../../modules/hyprland/hyprland.nix
    ./../../modules/fonts.nix

    # Desktop hardware & services
    ./../../modules/desktop/hardware.nix
    ./../../modules/desktop/services.nix
    ./../../modules/desktop/pkgs.nix
    ./../../modules/desktop/network.nix
    ./../../modules/thunar.nix
    ./../../modules/vicinae.nix
    ./../../modules/media.nix
    ./../../modules/bluetooth.nix

    # System services
    ./../../modules/logs.nix
    ./../../modules/ssh.nix
    ./../../modules/disk.nix
    ./../../modules/security.nix
    ./../../modules/home-manager.nix

    # Tools & utilities
    ./../../modules/utilities.nix
    ./../../modules/nix-index.nix
    ./../../modules/btop.nix
    ./../../modules/yt-download.nix
    ./../../modules/starship.nix
    ./../../modules/fzf.nix
    ./../../modules/yazi.nix
    ./../../modules/htop.nix
    ./../../modules/bat.nix
    ./../../modules/zoxide.nix
    ./../../modules/libvirtd.nix

    # Development
    ./../../modules/git.nix
    ./../../modules/direnv.nix
    ./../../modules/lazygit.nix
    ./../../modules/vscode/vscode.nix
    ./../../modules/docker.nix
    ./../../modules/nvf.nix

    # Applications
    ./../../modules/steam.nix
    ./../../modules/firefox.nix
    ./../../modules/obs.nix

    # Config & misc
    ./../../modules/nix.nix
    ./../../modules/time.nix
    ./../../modules/zsh.nix
    ./../../modules/lang-indicator.nix
    ./../../modules/backlight-indicator.nix
    ./../../modules/kbd-backlight-idle.nix
    ./../../modules/tailscale.nix
    ./../../modules/gtk.nix
    ./../../modules/qt.nix
    ./../../modules/ghostty.nix
    ./../../modules/xdg.nix

    # Scripts
    ./../../modules/scripts/double-click.nix
    ./../../modules/scripts/syncsupprep.nix
    ./../../modules/scripts/toggleTouchpad.nix
    ./../../modules/scripts/toggleDisplay.nix
    ./../../modules/scripts/hm-find.nix
    ./../../modules/scripts/toggleXWaylandScale.nix
  ];

  programs = {
    amnezia-vpn.enable = true;
    localsend.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Programming languages
    go # Go programming language
    nixd # Nix LSP
    dart # Dart language
    kotlin # Kotlin language
    typescript # EXTREMLY BAD language
    # zulu # Open JDK fast

    # Development tools

    gcc
    impression
    unrar # RAR archive extractor
    unzip # ZIP archive extractor
    meson # Build system
    gradle # Build system
    ninja # Build system
    nixfmt # Nix code formatter
    pkg-config # Package configuration tool
    nodejs # JavaScript runtime
    opencode
    supabase-cli
    postgresql
    pgadmin4-desktopmode

    # Desktop suite
    pom
    anki-bin # Spaced repetition flashcards
    libreoffice-qt-fresh # Office suite
    obsidian # Personal knowledge base
    zathura # PDF viewer

    # Communication & Internet
    discord # Chat and voice communication
    # protonvpn-gui # ProtonVPN client
    telegram-desktop # Instant messaging
    tor-browser # Privacy-focused browser
    # chromium
    # vesktop #discord alternative web thingne

    # Media Creation & Editing
    krita # Photoshop
    # audacity # Audio editor
    vlc
    mpv # Media player

    # Gaming
    # starsector
    # vintagestory
    # prismlauncher # Minecraft launcher
    # lutris # Game launchers gog epic games etc
    # hydralauncher #Games from different sources
  ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
