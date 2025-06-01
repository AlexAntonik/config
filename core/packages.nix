{
  pkgs,
  ...
}:
{
  programs = {
    dconf.enable = true; # Configuration editor
    seahorse.enable = true; # Password manager
    fuse.userAllowOther = true; # Allow users to mount FUSE filesystems
    virt-manager.enable = true; # Virtual machine manager
    mtr.enable = true; # My traceroute
    adb.enable = true; # Android Debug Bridge
    # amnezia-vpn.enable = true; # Right now, working only on ustable channel
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
    }; # File manager
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [

    # Programming languages
    go # Go programming language
    nixd # Nix LSP
    dart # Dart language
    kotlin # Kotlin language
    typescript # EXTREMLY BAD language
    zulu # Open JDK fast

    # Development tools
    docker-compose # Allows controlling Docker from a single file
    meson # Build system
    gradle # Build system
    ninja # Build system
    nixfmt-rfc-style # Nix code formatter
    pkg-config # Package configuration tool

    # Desk apps
    vlc
    protonvpn-gui # ProtonVPN client
    # vesktop #discord alternative web thingne
    zathura # PDF viewer

    # Bluetooth
    bluez-alsa # Bluetooth ALSA support
    bluez # Bluetooth utilities
    bluez-tools # Bluetooth tools
    blueman # Bluetooth manager

    # Utilities
    appimage-run # Needed for AppImage support
    wireguard-tools # WireGuard tools
    brightnessctl # For screen brightness control
    bottom # another tui system usage interface
    cliphist # Clipboard manager using rofi menu
    cloc # Count lines of code
    duf # Utility for viewing disk usage in terminal
    dysk # Get information on your mounted disks tool
    eza # Beautiful ls replacement
    ffmpeg # Terminal video/audio editing
    file-roller # Archive manager
    gawk # GNU awk
    #gh # GitHub CLI (enabled in home manager)
    htop # Simple terminal-based system monitor
    imv # Image viewer
    inxi # System information tool
    killall # Command to kill processes
    libnotify # Notification library
    lm_sensors # Hardware monitoring
    lshw # Hardware information tool
    ncdu # Disk usage analyzer
    pavucontrol # PulseAudio volume control
    nwg-displays # configure monitor configs via GUI
    nwg-drawer # Rofi like menu
    pamixer # Command-line mixer for PulseAudio
    easyeffects # Audio effects for PipeWire
    pciutils # PCI utilities
    playerctl # Media player controller
    jq # Command-line JSON processor
    ripgrep # Fast search tool
    socat # Multipurpose relay
    unrar # RAR archive extractor
    unzip # ZIP archive extractor
    usbutils # USB utilities
    v4l-utils # Video4Linux utilities
    wget # Network downloader
    wtype # typing thing
    # lazygit # Terminal-based Git interface
    ytmdl # YouTube music downloader

    # Media
    mpv # Media player

    # Virtualization
    libvirt # Virtualization library
    virt-viewer # Virtual machine viewer

    # Miscellaneous
    greetd.tuigreet # The login manager (sometimes referred to as display manager)
    hyprpicker # Color picker
  ];
}
