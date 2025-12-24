{
  pkgs,
  inputs,
  env,
  ...
}:
{
  imports = [
    ./hardware.nix # User defined hardware configuration
    ./hardware-gen.nix # Nix generated hardware configuration
    ./env.nix # Host variables

    ./../../system/boot.nix
    ./../../system/boot-visuals.nix # Boot visuals and login manager
    ./../../system/fonts.nix
    ./../../system/desktop/hardware.nix # Desktop hardware configuration
    ./../../system/desktop/services.nix # Desktop services & utils for keyboard,hyprland
    ./../../system/desktop/pkgs.nix # Desktop system packages
    ./../../system/desktop/network.nix # Desktop network configuration
    ./../../system/thunar.nix # Desktop file manager
    ./../../system/media.nix # Audio and multimedia configuration and pkgs
    # ./../../system/printing.nix # Printing configuration
    ./../../system/bluetooth.nix # Bluetooth configuration
    ./../../system/nh.nix # Nix helper
    ./../../system/utilities.nix # TUI utilities and tools
    ./../../system/ssh.nix # SSH configuration
    ./../../system/security.nix # Security settings (Polkit, RTkit, PAM)
    ./../../system/services.nix # General services (Journald, Fstrim, etc.)
    # ./../../system/srv/bkp.nix # Backup supabase script
    # ./../../system/srv/supabase-restart.nix # Supabase restart script
    ./../../system/lang-indicator.nix # Indicates wrong lang
    ./../../system/starship.nix
    ./../../system/git.nix
    ./../../system/secrets/sops.nix
    ./../../system/steam.nix
    ./../../system/stylix.nix # Stylix config
    ./../../system/nix.nix
    ./../../system/time.nix
    # ./../../system/tmux.nix 
    ./../../system/obs.nix # OBS with virtual camera
    ./../../system/lazygit.nix # Git tui
    ./../../system/htop.nix # htop
    ./../../system/bat.nix # More cute cat
    ./../../system/docker.nix
    ./../../system/libvirtd.nix
    ./../../system/variables.nix # Host variables(env) support
    ./../../system/zsh.nix # Shell system wide
    ./../../system/zoxide.nix # cd alternative super nice
    ./../../system/nvf.nix # vim
    ./../../system/tailscale.nix # Tailscale service
    ./syncthing.nix

    inputs.stylix.nixosModules.stylix # Stylix module for themes

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
    unstable.code-cursor
    # unstable.vscode.fhs # Visual Studio Code with FHS environment
    supabase-cli
    postgresql
    tailscale-systray

    # Desktop suite
    pom
    anki # Spaced repetition flashcards
    libreoffice # Office suite
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
    (import ./../../system/scripts/double-click.nix { inherit pkgs; })
    (import ./../../system/scripts/nvidia-offload.nix { inherit pkgs; })
    (import ./../../system/scripts/syncsupprep.nix { inherit pkgs env; })
    (import ./../../system/scripts/toggleTouchpad.nix { inherit pkgs env; })
    (import ./../../system/scripts/toggleDisplay.nix { inherit pkgs env; })
    (import ./../../system/scripts/hm-find.nix { inherit pkgs; })
    (import ./../../system/scripts/screenshot.nix { inherit pkgs; })
    (import ./../../system/scripts/toggleXWaylandScale.nix { inherit pkgs; })

    # Gaming
    # starsector
    # vintagestory
    prismlauncher # Minecraft launcher
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
      imports = [
        # CLI utilities
        ./../../home/btop.nix
        ./../../home/fzf.nix
        ./../../home/yazi.nix
        ./../../home/gh.nix

        # Applications
        ./../../home/firefox.nix
        ./../../home/virtmanager.nix
        ./../../home/vscode/vscode.nix

        # Theming and appearance
        ./../../home/gtk.nix
        ./../../home/qt.nix
        ./../../home/stylix.nix # Stylix targets

        # Desktop environment and panels
        ./../../home/hyprland/hyprland.nix
        ./../../home/waybar.nix
        ./../../home/mako.nix
        ./../../home/swayosd.nix
        ./../../home/ghostty.nix
        ./../../home/xdg.nix
        ./../../home/vicinae.nix
      ];
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
  nix.settings.allowed-users = [ "${env.username}" ];
}
