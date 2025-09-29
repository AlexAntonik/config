{
  pkgs,
  inputs,
  username,
  host,
  ...
}:
let
  inherit (import ./env.nix) gitUsername;
in
{
  imports = [
    ./hardware.nix # User defined hardware configuration
    ./hardware-gen.nix # Nix generated hardware configuration

    ./../../system/boot.nix
    ./../../system/boot-visuals.nix # Boot visuals and login manager
    ./../../system/fonts.nix
    ./../../system/desktop/hardware.nix # Desktop hardware configuration
    ./../../system/desktop/pkgs.nix # Desktop system packages
    ./../../system/desktop/services.nix # Desktop services & utils for keyboard,hyprland
    ./../../system/desktop/network.nix # Desktop network configuration
    ./../../system/thunar.nix # Desktop file manager
    ./../../system/media.nix # Audio and multimedia configuration and pkgs
    ./../../system/printing.nix # Printing configuration
    ./../../system/bluetooth.nix # Bluetooth configuration
    ./../../system/nh.nix # Nix helper
    ./../../system/utilities.nix # TUI utilities and tools
    ./../../system/ssh.nix # SSH configuration
    ./../../system/security.nix # Security settings (Polkit, RTkit, PAM)
    ./../../system/services.nix # General services (Journald, Fstrim, etc.)
    # ./../../system/lang-indicator.nix    # Indicates wrong lang
    ./../../system/starship.nix
    ./../../system/git.nix
    ./../../system/steam.nix
    ./../../system/stylix.nix # Stylix config
    ./../../system/obs.nix # OBS with virtual camera
    ./../../system/lazygit.nix # Git tui
    ./../../system/htop.nix # htop
    ./../../system/bat.nix # More cute cat
    ./../../system/time.nix
    ./../../system/nix.nix
    ./../../system/docker.nix
    ./../../system/libvirtd.nix
    ./../../system/zsh.nix #Shell system wide
    ./../../system/zoxide.nix #cd alternative super nice
    ./../../system/nvf.nix # vim

    inputs.stylix.nixosModules.stylix # Stylix module for themes

    inputs.home-manager.nixosModules.home-manager
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
    # postgresql

    # Desktop suite
    # anki # Spaced repetition flashcards
    # libreoffice # Office suite
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
    # ytmdl # YouTube music downloader

    # Scripts
    (import ./../../system/scripts/clipboard.nix { inherit pkgs; })
    (import ./../../system/scripts/double-click.nix { inherit pkgs; })
    (import ./../../system/scripts/task-waybar.nix { inherit pkgs; })
    (import ./../../system/scripts/nvidia-offload.nix { inherit pkgs; })
    (import ./../../system/scripts/syncsupprep.nix { inherit pkgs username; })
    (import ./../../system/scripts/toggleTouchpad.nix { inherit pkgs host; })
    (import ./../../system/scripts/toggleDisplay.nix { inherit pkgs host; })
    (import ./../../system/scripts/rofi-launcher.nix { inherit pkgs; })
    (import ./../../system/scripts/hm-find.nix { inherit pkgs; })
    (import ./../../system/scripts/screenshot.nix { inherit pkgs; })
    (import ./../../system/scripts/toggleXWaylandScale.nix { inherit pkgs; })

    # Gaming
    # starsector
    # vintagestory
    # prismlauncher # Minecraft launcher
    # lutris # Game launchers gog epic games etc
    # hydralauncher #Games from different sources
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit
        inputs
        username
        host
        ;
    };
    users.${username} = {
      imports = [
        # CLI utilities
        ./../../home/btop.nix
        ./../../home/eza.nix
        ./../../home/fzf.nix
        ./../../home/yazi/yazi.nix
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
        ./../../home/wlogout/wlogout.nix
        ./../../home/rofi.nix
        ./../../home/swaync.nix
        ./../../home/swayosd.nix
        ./../../home/ghostty.nix

        # Scripts and some configs
        ./../../home/scripts/clipboard.nix # Fancy clipboard manager for Rofi
        ./../../home/xdg.nix
      ];
      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";

        # This value determines the Home Manager release that your configuration is
        # compatible with. This helps avoid breakage when a new Home Manager release
        # introduces backwards incompatible changes.
        #
        # You should not change this value, even if you update Home Manager. If you do
        # want to update the value, then make sure to first check the Home Manager
        # release notes.
        stateVersion = "25.05"; # READ COMMENT
      };
    };
  };

  # This option defines the first version of NixOS you have installed on
  # this particular machine, and is used to maintain compatibility with
  # application data (e.g. databases) created on older NixOS versions.
  system.stateVersion = "25.05"; # Do not change!

  users.mutableUsers = true;
  users.defaultUserShell = pkgs.zsh;
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
