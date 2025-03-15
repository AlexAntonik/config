{pkgs, ...}: {
  programs = {
    firefox.enable = false; # Firefox is not installed by defualt
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    virt-manager.enable = true;
    mtr.enable = true;
    adb.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
 # Programming languages
    go # Go programming language

    # Development tools
    vscode # Visual Studio Code editor
    docker-compose # Allows controlling Docker from a single file
    meson # Build system
    ninja # Build system
    nixfmt-rfc-style # Nix code formatter
    pkg-config # Package configuration tool
    zulu #Open JDK fast

    # Desk apps
    microsoft-edge # Web browser
    telegram-desktop # Telegram client
    protonvpn-gui # ProtonVPN client
    tor-browser # Tor

    # Bluetooth
    bluez-alsa # Bluetooth ALSA support
    bluez # Bluetooth utilities
    bluez-tools # Bluetooth tools
    blueman # Bluetooth manager

    # Utilities
    appimage-run # Needed for AppImage support
    brightnessctl # For screen brightness control
    duf # Utility for viewing disk usage in terminal
    eza # Beautiful ls replacement
    ffmpeg # Terminal video/audio editing
    file-roller # Archive manager
    htop # Simple terminal-based system monitor
    imv # Image viewer
    inxi # System information tool
    killall # Command to kill processes
    libnotify # Notification library
    lm_sensors # Hardware monitoring
    lshw # Hardware information tool
    ncdu # Disk usage analyzer
    pavucontrol # PulseAudio volume control
    pamixer # Command-line mixer for PulseAudio
    easyeffects # Audio effects for PipeWire
    pciutils # PCI utilities
    playerctl # Media player controller
    ripgrep # Fast search tool
    socat # Multipurpose relay
    unrar # RAR archive extractor
    unzip # ZIP archive extractor
    usbutils # USB utilities
    v4l-utils # Video4Linux utilities
    wget # Network downloader
    ytmdl # YouTube music downloader

    # Media
    gimp # Great photo editor
    mpv # Media player
    picard # Music tagger

    # Virtualization
    libvirt # Virtualization library
    virt-viewer # Virtual machine viewer

    # Miscellaneous
    prismlauncher # Prism launcher
    greetd.tuigreet # The login manager (sometimes referred to as display manager)
    hyprpicker # Color picker
    lxqt.lxqt-policykit # PolicyKit authentication agent
  ];
}
