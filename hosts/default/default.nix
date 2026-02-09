{
  pkgs,
  username,
  gitUsername,
  ...
}:
{
  imports = [
    ./hardware.nix # User defined hardware configuration
    ./hardware-gen.nix # Nix generated hardware configuration
    ./env.nix # Host variables

    ./../../modules/boot.nix
    ./../../modules/boot-visuals.nix # Boot visuals and login manager
    ./../../modules/fonts.nix
    ./../../modules/desktop/hardware.nix # Desktop hardware configuration
    ./../../modules/desktop/pkgs.nix # Desktop system packages
    ./../../modules/desktop/services.nix # Desktop services & utils for keyboard,hyprland
    ./../../modules/desktop/network.nix # Desktop network configuration
    ./../../modules/thunar.nix # Desktop file manager
    ./../../modules/media.nix # Audio and multimedia configuration and pkgs
    ./../../modules/printing.nix # Printing configuration
    ./../../modules/bluetooth.nix # Bluetooth configuration
    ./../../modules/nh.nix # Nix helper
    ./../../modules/utilities.nix # TUI utilities and tools
    ./../../modules/ssh.nix # SSH configuration
    ./../../modules/security.nix # Security settings (Polkit, RTkit, PAM)
    ./../../modules/services.nix # General services (Journald, Fstrim, etc.)
    # ./../../modules/lang-indicator.nix    # Indicates wrong lang
    ./../../modules/starship.nix
    ./../../modules/git.nix
    ./../../modules/steam.nix
    ./../../modules/firefox.nix
    ./../../modules/stylix.nix # Stylix config
    ./../../modules/obs.nix # OBS with virtual camera
    ./../../modules/lazygit.nix # Git tui
    ./../../modules/htop.nix # htop
    ./../../modules/home-manager.nix
    ./../../modules/bat.nix # More cute cat
    ./../../modules/time.nix
    ./../../modules/nix.nix
    ./../../modules/docker.nix
    ./../../modules/libvirtd.nix
    ./../../modules/options.nix # Host options glue
    ./../../modules/zsh.nix # Shell system wide
    ./../../modules/zoxide.nix # cd alternative super nice
    ./../../modules/nvf.nix # vim
    ./../../modules/btop.nix
    ./../../modules/fzf.nix
    ./../../modules/yazi.nix
    ./../../modules/virtmanager.nix
    ./../../modules/vscode/vscode.nix
    ./../../modules/gtk.nix
    ./../../modules/qt.nix
    ./../../modules/stylix.nix # Stylix targets
    ./../../modules/hyprland/hyprland.nix
    ./../../modules/ghostty.nix
    ./../../modules/vicinae.nix
    ./../../modules/xdg.nix
    ./../../modules/noctalia/noctalia.nix

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
    # adb.enable = true; # Android Debug Bridge
    # amnezia-vpn.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Programming languages
    # go # Go programming language
    # nixd # Nix LSP
    # dart # Dart language
    # kotlin # Kotlin language
    # typescript # EXTREMLY BAD language
    zulu # Open JDK fast

    # Development tools
    # meson # Build system
    # gradle # Build system
    # ninja # Build system
    # nixfmt-rfc-style # Nix code formatter
    # pkg-config # Package configuration tool
    # android-studio # Android IDE
    # nodejs # JavaScript runtime
    # unstable.code-cursor
    # unstable.vscode.fhs # Visual Studio Code with FHS environment
    # supabase-cli
    # unrar # RAR archive extractor
    # unzip # ZIP archive extractor
    # postgresql

    # Desktop suite
    # anki # Spaced repetition flashcards
    # libreoffice-qt-still # Office suite
    # obsidian # Personal knowledge base
    # zathura # PDF viewer

    # Communication & Internet
    # discord # Chat and voice communication
    # protonvpn-gui # ProtonVPN client
    # telegram-desktop # Instant messaging
    # tor-browser # Privacy-focused browser
    # chromium
    # vesktop #discord alternative web thingne

    # Media Creation & Editing
    # gimp # Image manipulation program
    # unstable.audacity # Audio editor
    # vlc
    # mpv # Media player
    # yt-dlp # YouTube downloader

    # Gaming
    # starsector
    # vintagestory
    # prismlauncher # Minecraft launcher
    # lutris # Game launchers gog epic games etc
    # hydralauncher #Games from different sources
  ];

  users.mutableUsers = true;
  users.users.${username} = {
    isNormalUser = true;
    description = "${gitUsername}";
    extraGroups = [
      "adbusers"
      "docker"
      "libvirtd"
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
