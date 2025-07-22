{
  pkgs,
  inputs,
  username,
  host,
  ...
}:
let
  inherit (import ./variables.nix) gitUsername;
in
{
  imports = [ 
    ./../../system/boot.nix
    ./../../system/boot-visuals.nix      # Boot visuals and login manager
    ./../../system/fonts.nix
    ./../../system/desktop-hardware.nix  # Desktop hardware configuration
    ./../../system/desktop-pkgs.nix      # Desktop system packages
    ./../../system/desktop-services.nix  # Desktop services & utils for keyboard,hyprland
    ./../../system/desktop-network.nix   # Desktop network configuration
    ./../../system/thunar.nix            # Desktop file manager
    ./../../system/media.nix             # Audio and multimedia configuration and pkgs
    ./../../system/printing.nix          # Printing configuration
    ./../../system/bluetooth.nix         # Bluetooth configuration
    ./../../system/nh.nix                # Nix helper
    ./../../system/utilities.nix         # TUI utilities and tools
    ./../../system/ssh.nix               # SSH configuration
    ./../../system/security.nix          # Security settings (Polkit, RTkit, PAM)
    ./../../system/services.nix          # General services (Journald, Fstrim, etc.)
    ./../../system/starship.nix
    ./../../system/git.nix
    ./../../system/steam.nix
    ./../../system/stylix.nix            # Stylix config
    ./../../system/time.nix
    ./../../system/nix.nix
    ./../../system/docker.nix
    ./../../system/libvirtd.nix
    ./syncthing.nix

    inputs.stylix.nixosModules.stylix # Stylix module for themes

    inputs.home-manager.nixosModules.home-manager
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
        ./../../home/bat.nix
        ./../../home/btop.nix
        ./../../home/emoji.nix
        ./../../home/htop.nix
        ./../../home/fastfetch
        ./../../home/eza.nix
        ./../../home/lazygit.nix
        ./../../home/fzf.nix
        ./../../home/yazi
        ./../../home/zoxide.nix
        ./../../home/gh.nix

        # Applications
        ./../../home/firefox.nix
        ./../../home/virtmanager.nix

        # Theming and appearance
        ./../../home/gtk.nix
        ./../../home/qt.nix
        ./../../home/stylix.nix           # Stylix targets

        # Desktop environment and panels
        ./../../home/hyprland
        ./../../home/waybar.nix
        ./../../home/wlogout
        ./../../home/rofi.nix
        ./../../home/swaync.nix
        ./../../home/swayosd.nix
        ./../../home/ghostty.nix

        # Scripts and some configs
        ./../../home/scripts/clipboard.nix
        ./../../home/xdg.nix
        ./../../home/zsh
        ./../../home/nvf.nix
      ];
      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";

        # Home scripts and utilities
        packages = [
          (import ./../../home/scripts/emopicker9000.nix { inherit pkgs; })
          (import ./../../home/scripts/task-waybar.nix { inherit pkgs; })
          (import ./../../home/scripts/nvidia-offload.nix { inherit pkgs; })
          (import ./../../home/scripts/wallsetter.nix {
            inherit pkgs;
            inherit username;
          })
          (import ./../../home/scripts/syncsupprep.nix {
            inherit pkgs;
            inherit username;
          })
          (import ./../../home/scripts/toggleTouchpad.nix {
            inherit pkgs;
            inherit host;
          })
          (import ./../../home/scripts/toggleDisplay.nix {
            inherit pkgs;
            inherit host;
          })
          (import ./../../home/scripts/rofi-launcher.nix { inherit pkgs; })
          (import ./../../home/scripts/hm-find.nix { inherit pkgs; })
          (import ./../../home/scripts/screenshootin.nix { inherit pkgs; })
          (import ./../../home/scripts/oneshot.nix { inherit pkgs; })
          (import ./../../home/scripts/toggleXWaylandScale.nix { inherit pkgs; })
        ];

        # This value determines the Home Manager release that your configuration is
        # compatible with. This helps avoid breakage when a new Home Manager release
        # introduces backwards incompatible changes.
        #
        # You should not change this value, even if you update Home Manager. If you do
        # want to update the value, then make sure to first check the Home Manager
        # release notes.
        stateVersion = "24.11"; #READ COMMENT
      };
    };
  };

  # This option defines the first version of NixOS you have installed on
  # this particular machine, and is used to maintain compatibility with
  # application data (e.g. databases) created on older NixOS versions.
  system.stateVersion = "23.11"; # Do not change!

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
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };
  nix.settings.allowed-users = [ "${username}" ];
}