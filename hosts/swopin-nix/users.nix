{
  pkgs,
  inputs,
  username,
  host,
  ...
}: let
  inherit (import ./variables.nix) gitUsername;
in {
  imports = [
    # ./../../system/boot.nix
    ./../../system/fonts.nix
    ./../../system/nh.nix # Nix helper
    ./../../system/utilities.nix         # TUI utilities and tools
    ./../../system/ssh.nix               # SSH configuration
    ./../../system/security.nix          # Security settings (Polkit, RTkit, PAM)
    ./../../system/services.nix          # General services (Journald, Fstrim, etc.)
    ./../../system/starship.nix
    ./../../system/git.nix
    ./../../system/stylix.nix # Stylix config
    ./../../system/time.nix
    ./../../system/nix.nix
    ./../../system/docker.nix

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
        ./../../home/htop.nix
        ./../../home/fastfetch
        ./../../home/eza.nix
        ./../../home/lazygit.nix
        ./../../home/fzf.nix
        ./../../home/yazi
        ./../../home/zoxide.nix

        # Theming and appearance
        ./../../home/stylix.nix # Stylix targets

        # Scripts and some configs
        ./../../home/zsh
        ./../../home/nvf.nix
      ];
      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";

        # Home scripts and utilities
        packages = [
          (import ./syncsupprep.nix {
            inherit pkgs;
            inherit username;
          })
          (import ./hm-find.nix { inherit pkgs; })
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
  users.users.root.openssh.authorizedKeys.keys = [''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILUSJwUYV0e+h3Rj4+YvrsqHuolIh45KHg9Lttid1+KI alex@alex'' ];
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
  nix.settings.allowed-users = ["${username}"];
}
