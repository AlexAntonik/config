{
  pkgs,
  inputs,
  username,
  lib,
  ...
}:
let
  inherit (import ./env.nix) gitUsername;
in
{
  imports = [
    ./networking.nix
    ./hardware-configuration.nix
    ./syncthing.nix

    # ./../../system/boot.nix
    # ./../../system/fonts.nix
    ./../../system/nh.nix # Nix helper
    ./../../system/utilities.nix # TUI utilities and tools
    ./../../system/ssh.nix # SSH configuration
    ./../../system/security.nix # Security settings (Polkit, RTkit, PAM)
    ./../../system/services.nix # General services (Journald, Fstrim, etc.)
    ./../../system/starship.nix
    ./../../system/git.nix
    ./../../system/stylix.nix # Stylix config
    ./../../system/lazygit.nix # Git tui
    ./../../system/htop.nix # htop
    ./../../system/bat.nix # More cute cat
    ./../../system/time.nix
    ./../../system/nix.nix
    ./../../system/docker.nix
    ./../../system/secrets/sops.nix
    ./../../system/srv/bkp.nix # Backup supabase script
    ./../../system/srv/supabase-restart.nix # Supabase restart script
    ./../../system/zsh.nix # Shell system wide
    ./../../system/zoxide.nix # cd alternative super nice
    ./../../system/nvf.nix # vim

    inputs.stylix.nixosModules.stylix # Stylix module for themes

    inputs.home-manager.nixosModules.home-manager
  ];

  programs = {
    # adb.enable = true; # Android Debug Bridge
  };
  environment.systemPackages = with pkgs; [
    supabase-cli
    postgresql
          (import ./../../system/scripts/syncsupprep.nix { inherit pkgs username; })
          (import ./../../system/scripts/hm-find.nix { inherit pkgs; })
  ];

  # This option defines the first version of NixOS you have installed on
  # this particular machine, and is used to maintain compatibility with
  # application data (e.g. databases) created on older NixOS versions.
  system.stateVersion = "23.11"; # Do not change!

  users.mutableUsers = true;
  users.defaultUserShell = pkgs.zsh;

  services.openssh = {
    settings = {
      PasswordAuthentication = lib.mkForce false; # Override from ssh.nix
    };
  };

  users.users.${username} = {
    openssh.authorizedKeys.keys = [
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILUSJwUYV0e+h3Rj4+YvrsqHuolIh45KHg9Lttid1+KI alex@alex''
      ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDYa5Spl+UBXgbeh3TyFQS2Sff+2vlKT1Oiu/aS/U0SbCTOxZOzZvyvIkvR5TmYUhy2ykMIL/cDaKgGEZ3S4kEHTvmd3Th6Sq6LammjlaH+lk3ZW97hU1mEoXHVmbOmXI5gn8NP8jp01PFGmKkYiF0U5jhm3ndBpR0AaJ6EeY/zpQqNpDP6BXFcvBwKGevckJvTPVkpMavOpzhGhTx7dYJZQ/+Lh0rKxhshyv+KOKvPF6jGfeYUc8RlG33ihJVldvEdAm+h1GmAQaBMv5ShD3okqamRyQ5JncwOvMlRTc1vlT+m/JQo+aU7P/n3SeqQfiIQvGC3gA58SkTwJ0ZMESElJstiqqENr9X531CkNbMh6w3977yuXJhkeTCAmxwdD1SN8eWvHfS+5iX8DqKePyUYIfYqPrpjXBkzOlwlEnmvDhRUiwb1vbnxc+VWe7tZjb1fIWpX7oeS0X6kHbzKcCF9ccpxXoZ1v1+bJTYA89hbwGi/FvSYfySp4VcrzBzRLtvSQOlQOyico0cxY2PPNcA+T0Mz5/LdrmUiXW1ZvStA6akDqhhqknKRRRtRwfFEnaxc/gkTNkm6VaVV9vE2dKDGYtj7Ehk97cCVWIZIhNs+ghBuvWvs3t5rdjhVlgInjYohCr5PuVGGo4Segm3fzWoSVmzpN5YML2ZQdG3M5fbPdw== siarheibautrukevich@mbp-siarhei''
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
  nix.settings.allowed-users = [ "${username}" ];
}
