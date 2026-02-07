{
  pkgs,
  inputs,
  env,
  ...
}: {
  imports = [
    ./hardware.nix # User defined hardware configuration
    ./hardware-gen.nix # Nix generated hardware configuration
    ./env.nix # Host variables

    ./../../modules/boot.nix
    ./../../modules/boot-visuals.nix # Boot visuals and login manager
    ./../../modules/fonts.nix
    ./../../modules/desktop/hardware.nix # Desktop hardware configuration
    ./../../modules/desktop/services.nix # Desktop services & utils for keyboard,hyprland
    ./../../modules/desktop/pkgs.nix # Desktop system packages
    ./../../modules/desktop/network.nix # Desktop network configuration
    ./../../modules/thunar.nix # Desktop file manager
    ./../../modules/media.nix # Audio and multimedia configuration and pkgs
    ./../../modules/bluetooth.nix # Bluetooth configuration
    ./../../modules/nh.nix # Nix helper
    ./../../modules/utilities.nix # TUI utilities and tools
    ./../../modules/ssh.nix # SSH configuration
    ./../../modules/security.nix # Security settings (Polkit, RTkit, PAM)
    ./../../modules/services.nix # General services (Journald, Fstrim, etc.)
    # ./../../modules/printing.nix # Printing configuration
    # ./../../modules/srv/bkp.nix # Backup supabase script
    # ./../../modules/srv/supabase-restart.nix # Supabase restart script
    ./../../modules/lang-indicator.nix # Indicates wrong lang
    ./../../modules/starship.nix
    ./../../modules/git.nix
    ./../../modules/secrets/sops.nix
    ./../../modules/steam.nix
    ./../../modules/firefox.nix
    ./../../modules/stylix.nix # Stylix config
    ./../../modules/nix.nix
    ./../../modules/time.nix
    # ./../../modules/tmux.nix
    ./../../modules/obs.nix # OBS with virtual camera
    ./../../modules/lazygit.nix # Git tui
    ./../../modules/htop.nix # htop
    ./../../modules/noctalia/noctalia.nix
    ./../../modules/bat.nix # More cute cat
    ./../../modules/docker.nix
    ./../../modules/libvirtd.nix
    ./../../modules/variables.nix # Host variables(env) support
    ./../../modules/zsh.nix # Shell system wide
    ./../../modules/zoxide.nix # cd alternative super nice
    ./../../modules/nvf.nix # vim
    ./../../modules/tailscale.nix # Tailscale service
    ./../../modules/btop.nix
    ./../../modules/fzf.nix
    ./../../modules/yazi.nix
    ./../../modules/virtmanager.nix
    ./../../modules/vscode/vscode.nix
    ./../../modules/gtk.nix
    ./../../modules/qt.nix
    ./../../modules/eww-clock.nix
    ./../../modules/hyprland/hyprland.nix
    ./../../modules/ghostty.nix
    ./../../modules/xdg.nix
    ./../../modules/vicinae.nix

    ./syncthing.nix

    inputs.home-manager.nixosModules.home-manager
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
    meson # Build system
    gradle # Build system
    ninja # Build system
    nixfmt-rfc-style # Nix code formatter
    pkg-config # Package configuration tool
    android-studio # Android IDE
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
    unstable.audacity # Audio editor
    vlc
    mpv # Media player
    yt-dlp # YouTube downloader

    # Scripts
    (import ./../../modules/scripts/double-click.nix {inherit pkgs;})
    (import ./../../modules/scripts/syncsupprep.nix {inherit pkgs env;})
    (import ./../../modules/scripts/toggleTouchpad.nix {inherit pkgs env;})
    (import ./../../modules/scripts/toggleDisplay.nix {inherit pkgs env;})
    (import ./../../modules/scripts/hm-find.nix {inherit pkgs;})
    (import ./../../modules/scripts/screenshot.nix {inherit pkgs;})
    (import ./../../modules/scripts/toggleXWaylandScale.nix {inherit pkgs;})

    # Gaming
    # starsector
    # vintagestory
    # prismlauncher # Minecraft launcher
    # lutris # Game launchers gog epic games etc
    # hydralauncher #Games from different sources
  ];

  # needed only for vintage story mb remove in future
  #           |
  #         \ | /
  #          \ /
  # nixpkgs.config.permittedInsecurePackages = [
  # "dotnet-runtime-7.0.20"
  # ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit inputs env;
    };
    users.${env.username} = {
      home = {
        username = "${env.username}";
        homeDirectory = "/home/${env.username}";

        # This value determines the Home Manager release that your configuration is
        # compatible with. This helps avoid breakage when a new Home Manager release
        # introduces backwards incompatible changes.
        #
        # You should not change this value, even if you update Home Manager. If you do
        # want to update the value, then make sure to first check the Home Manager
        # release notes.
        stateVersion = "24.11"; # READ COMMENT
      };
    };
  };

  # This option defines the first version of NixOS you have installed on
  # this particular machine, and is used to maintain compatibility with
  # application data (e.g. databases) created on older NixOS versions.
  system.stateVersion = "23.11"; # Do not change!

  users.defaultUserShell = pkgs.zsh;
  users.mutableUsers = true;
  users.users.${env.username} = {
    isNormalUser = true;
    description = "${env.gitUsername}";
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
  nix.settings.allowed-users = ["${env.username}"];
}
