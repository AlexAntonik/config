{
  pkgs,
  username,
  gitUsername,
  ...
}:
{
  imports = [
    # Host specific config
    ./hardware.nix
    ./hardware-gen.nix
    ./env.nix
    ./syncthing.nix

    # System boot & visuals
    ./../../modules/boot.nix
    ./../../modules/boot-visuals.nix
    ./../../modules/noctalia/noctalia.nix
    ./../../modules/stylix.nix
    ./../../modules/eww-clock.nix
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
    ./../../modules/services.nix
    ./../../modules/ssh.nix
    ./../../modules/security.nix
    ./../../modules/home-manager.nix

    # Tools & utilities
    ./../../modules/utilities.nix
    ./../../modules/btop.nix
    ./../../modules/starship.nix
    ./../../modules/fzf.nix
    ./../../modules/yazi.nix
    ./../../modules/htop.nix
    ./../../modules/bat.nix
    ./../../modules/zoxide.nix
    ./../../modules/libvirtd.nix

    # Development
    ./../../modules/git.nix
    ./../../modules/lazygit.nix
    ./../../modules/vscode/vscode.nix
    ./../../modules/docker.nix
    ./../../modules/nvf.nix

    # Nix related
    ./../../modules/nix.nix
    ./../../modules/nh.nix
    ./../../modules/options.nix

    # Applications
    ./../../modules/steam.nix
    ./../../modules/firefox.nix
    ./../../modules/obs.nix

    # Config & misc
    ./../../modules/time.nix
    ./../../modules/secrets/sops.nix
    ./../../modules/zsh.nix
    ./../../modules/lang-indicator.nix
    ./../../modules/tailscale.nix
    ./../../modules/virtmanager.nix
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
    ./../../modules/scripts/screenshot.nix
    ./../../modules/scripts/toggleXWaylandScale.nix
  ];

  programs = {
    adb.enable = true; # Android Debug Bridge
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

    unrar # RAR archive extractor
    unzip # ZIP archive extractor
    meson # Build system
    gradle # Build system
    ninja # Build system
    nixfmt-rfc-style # Nix code formatter
    pkg-config # Package configuration tool
    # android-studio # Android IDE
    nodejs # JavaScript runtime
    opencode
    # unstable.vscode.fhs # Visual Studio Code with FHS environment
    supabase-cli
    postgresql

    # Desktop suite
    pom
    anki-bin # Spaced repetition flashcards
    # libreoffice-qt-fresh # Office suite
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
    gimp # Image manipulation program
    # audacity # Audio editor
    vlc
    mpv # Media player
    yt-dlp # YouTube downloader

    # Gaming
    # starsector
    # vintagestory
    # prismlauncher # Minecraft launcher
    # lutris # Game launchers gog epic games etc
    # hydralauncher #Games from different sources
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  users.mutableUsers = true;
  users.users.${username} = {
    isNormalUser = true;
    description = "${gitUsername}";
    extraGroups = [
      "adbusers"
      "docker"
      "libvirtd"
      "input"
      "kvm"
      "lp"
      "networkmanager"
      "scanner"
      "wheel"
    ];
    ignoreShellProgramCheck = true;
  };
  nix.settings.allowed-users = [ "${username}" ];
}
