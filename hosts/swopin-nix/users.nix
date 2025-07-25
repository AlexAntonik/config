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
    ./../../system/utilities.nix # TUI utilities and tools
    ./../../system/ssh.nix # SSH configuration
    ./../../system/security.nix # Security settings (Polkit, RTkit, PAM)
    ./../../system/services.nix # General services (Journald, Fstrim, etc.)
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
        ./../../home/ghostty.nix

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
          (import ./../../home/scripts/syncsupprep.nix {
            inherit pkgs;
            inherit username;
          })
          (import ./../../home/scripts/hm-find.nix {inherit pkgs;})
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
  users.users.root.openssh.authorizedKeys.keys = [
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILUSJwUYV0e+h3Rj4+YvrsqHuolIh45KHg9Lttid1+KI alex@alex''
    ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDYa5Spl+UBXgbeh3TyFQS2Sff+2vlKT1Oiu/aS/U0SbCTOxZOzZvyvIkvR5TmYUhy2ykMIL/cDaKgGEZ3S4kEHTvmd3Th6Sq6LammjlaH+lk3ZW97hU1mEoXHVmbOmXI5gn8NP8jp01PFGmKkYiF0U5jhm3ndBpR0AaJ6EeY/zpQqNpDP6BXFcvBwKGevckJvTPVkpMavOpzhGhTx7dYJZQ/+Lh0rKxhshyv+KOKvPF6jGfeYUc8RlG33ihJVldvEdAm+h1GmAQaBMv5ShD3okqamRyQ5JncwOvMlRTc1vlT+m/JQo+aU7P/n3SeqQfiIQvGC3gA58SkTwJ0ZMESElJstiqqENr9X531CkNbMh6w3977yuXJhkeTCAmxwdD1SN8eWvHfS+5iX8DqKePyUYIfYqPrpjXBkzOlwlEnmvDhRUiwb1vbnxc+VWe7tZjb1fIWpX7oeS0X6kHbzKcCF9ccpxXoZ1v1+bJTYA89hbwGi/FvSYfySp4VcrzBzRLtvSQOlQOyico0cxY2PPNcA+T0Mz5/LdrmUiXW1ZvStA6akDqhhqknKRRRtRwfFEnaxc/gkTNkm6VaVV9vE2dKDGYtj7Ehk97cCVWIZIhNs+ghBuvWvs3t5rdjhVlgInjYohCr5PuVGGo4Segm3fzWoSVmzpN5YML2ZQdG3M5fbPdw== siarheibautrukevich@mbp-siarhei''
  ];
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
