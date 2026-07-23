{ pkgs, ... }: {
  host = {
    # Locals
    username = "alex";
    hostname = "asus"; # Must be the same as dir name

    gitUsername = "AlexAntonik";
    gitEmail = "antonikavv@gmail.com";

    # Time and Locale Settings
    timeZone = "Europe/Minsk";

    stateVersion = "26.05";
  };

  imports = [
    # Host specific config
    ./hardware.nix
    ./hardware-gen.nix
    ./syncthing.nix

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
    ./../../modules/bat.nix
    ./../../modules/zoxide.nix
    ./../../modules/virtualisation.nix

    # Development
    ./../../modules/git.nix
    ./../../modules/direnv.nix
    ./../../modules/lazygit.nix
    ./../../modules/vscode/vscode.nix
    ./../../modules/docker.nix
    ./../../modules/nvim/nvim-full.nix

    # Applications
    ./../../modules/steam.nix
    ./../../modules/firefox.nix
    ./../../modules/obs.nix
    ./../../modules/office.nix

    # Config & misc
    ./../../modules/nix.nix
    ./../../modules/time.nix
    ./../../modules/zsh.nix
    (import ./../../modules/lang-indicator.nix { languageLightID = "platform::micmute"; })
    (import ./../../modules/kbd-backlight.nix {
      kbdIdleTimeout = "120";
      keyboardLightID = "asus::kbd_backlight";
      mainMonitor = "eDP-1";
      keyboardScreenOFFLightID = "asus::camera";
    })
    ./../../modules/tailscale.nix
    ./../../modules/ghostty.nix
    ./../../modules/xdg.nix

    # Scripts
    ./../../modules/scripts/syncsupprep.nix
    (import ./../../modules/scripts/toggleTouchpad.nix {
      touchpadID = "asue120b:00-04f3:31c0-touchpad";
    })
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
    typescript # EXTREMELY BAD language
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
    nodejs # JavaScript runtime
    opencode
    supabase-cli
    postgresql
    pgadmin4-desktopmode

    # Desktop suite
    pom
    anki-bin # Spaced repetition flashcards
    obsidian # Personal knowledge base

    # Communication & Internet
    discord # Chat and voice communication
    telegram-desktop # Instant messaging
    # tor-browser # Privacy-focused browser
    # chromium
    # vesktop #discord alternative web thingne

    # Media Creation & Editing
    krita # Photoshop
    # audacity # Audio editor
    vlc

    # Gaming
    # starsector
    # vintagestory
    # prismlauncher # Minecraft launcher
    # lutris # Game launchers gog epic games etc
    # hydralauncher #Games from different sources
  ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
