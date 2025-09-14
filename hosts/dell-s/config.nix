{
  pkgs,
  username,
  ...
}: let
  inherit (import ./env.nix) gitUsername;
in {
  imports = [
    ./hardware.nix # User defined hardware configuration
    ./hardware-gen.nix # Nix generated hardware configuration

    ./../../system/boot.nix
    ./../../system/fonts.nix
    ./../../system/srv/network-wifi.nix
    ./../../system/nh.nix # Nix helper
    ./../../system/utilities.nix # TUI utilities and tools
    ./../../system/ssh.nix # SSH configuration
    ./../../system/security.nix # Security settings (Polkit, RTkit, PAM)
    ./../../system/services.nix # General services (Journald, Fstrim, etc.)
    ./../../system/starship.nix
    ./../../system/tailscale.nix # Tailscale service
    ./../../system/git.nix
    ./../../system/secrets/sops.nix
    ./../../system/time.nix
    ./../../system/lazygit.nix # Git tui
    ./../../system/htop.nix # htop
    ./../../system/bat.nix # More cute cat
    ./../../system/nix.nix
    ./../../system/docker.nix
    ./../../system/zsh.nix #Shell system wide
    ./../../system/zoxide.nix #cd alternative super nice
    ./../../system/nvf.nix # vim
    # ./cloudflared.nix
    ./syncthing.nix

  ];

  programs = {
    # adb.enable = true; # Android Debug Bridge
    # amnezia-vpn.enable = true;
  };
  environment.systemPackages = [
          (import ./../../system/scripts/syncsupprep.nix {
            inherit pkgs;
            inherit username;
          })
          (import ./../../system/scripts/hm-find.nix {inherit pkgs;})
  ];

  # This option defines the first version of NixOS you have installed on
  # this particular machine, and is used to maintain compatibility with
  # application data (e.g. databases) created on older NixOS versions.
  system.stateVersion = "23.11"; # Do not change!

  # prevent load when lid closed
  services.logind.lidSwitch = "ignore";

  users.mutableUsers = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.${username} = {
    openssh.authorizedKeys.keys = [
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILUSJwUYV0e+h3Rj4+YvrsqHuolIh45KHg9Lttid1+KI alex@alex''
    ];
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
  nix.settings.allowed-users = ["${username}"];
}
