{
  pkgs,
  env,
  lib,
  ...
}:
{
  imports = [
    ./networking.nix
    ./hardware-configuration.nix
    ./syncthing.nix
    ./env.nix # Host variables

    # ./../../modules/boot.nix
    # ./../../modules/fonts.nix
    ./../../modules/nh.nix # Nix helper
    ./../../modules/utilities.nix # TUI utilities and tools
    ./../../modules/ssh.nix # SSH configuration
    ./../../modules/security.nix # Security settings (Polkit, RTkit, PAM)
    ./../../modules/services.nix # General services (Journald, Fstrim, etc.)
    ./../../modules/starship.nix
    ./../../modules/git.nix
    ./../../modules/stylix.nix # Stylix config
    ./../../modules/lazygit.nix # Git tui
    ./../../modules/htop.nix # htop
    ./../../modules/bat.nix # More cute cat
    ./../../modules/time.nix
    ./../../modules/nix.nix
    ./../../modules/docker.nix
    ./../../modules/secrets/sops.nix
    ./../../modules/options.nix # Host options glue
    ./../../modules/srv/bkp.nix # Backup supabase script
    ./../../modules/srv/supabase-restart.nix # Supabase restart script
    ./../../modules/zsh.nix # Shell system wide
    ./../../modules/zoxide.nix # cd alternative super nice
    ./../../modules/nvf.nix # vim
  ];

  programs = {
    # adb.enable = true; # Android Debug Bridge
  };
  environment.systemPackages = with pkgs; [
    supabase-cli
    postgresql
    (import ./../../modules/scripts/syncsupprep.nix { inherit pkgs env; })
  ];

  users.mutableUsers = true;
  users.defaultUserShell = pkgs.zsh;

  services.openssh = {
    settings = {
      PasswordAuthentication = lib.mkForce false; # Override from ssh.nix
    };
  };

  users.users.${env.username} = {
    openssh.authorizedKeys.keys = [
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILUSJwUYV0e+h3Rj4+YvrsqHuolIh45KHg9Lttid1+KI alex@alex''
      ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDYa5Spl+UBXgbeh3TyFQS2Sff+2vlKT1Oiu/aS/U0SbCTOxZOzZvyvIkvR5TmYUhy2ykMIL/cDaKgGEZ3S4kEHTvmd3Th6Sq6LammjlaH+lk3ZW97hU1mEoXHVmbOmXI5gn8NP8jp01PFGmKkYiF0U5jhm3ndBpR0AaJ6EeY/zpQqNpDP6BXFcvBwKGevckJvTPVkpMavOpzhGhTx7dYJZQ/+Lh0rKxhshyv+KOKvPF6jGfeYUc8RlG33ihJVldvEdAm+h1GmAQaBMv5ShD3okqamRyQ5JncwOvMlRTc1vlT+m/JQo+aU7P/n3SeqQfiIQvGC3gA58SkTwJ0ZMESElJstiqqENr9X531CkNbMh6w3977yuXJhkeTCAmxwdD1SN8eWvHfS+5iX8DqKePyUYIfYqPrpjXBkzOlwlEnmvDhRUiwb1vbnxc+VWe7tZjb1fIWpX7oeS0X6kHbzKcCF9ccpxXoZ1v1+bJTYA89hbwGi/FvSYfySp4VcrzBzRLtvSQOlQOyico0cxY2PPNcA+T0Mz5/LdrmUiXW1ZvStA6akDqhhqknKRRRtRwfFEnaxc/gkTNkm6VaVV9vE2dKDGYtj7Ehk97cCVWIZIhNs+ghBuvWvs3t5rdjhVlgInjYohCr5PuVGGo4Segm3fzWoSVmzpN5YML2ZQdG3M5fbPdw== siarheibautrukevich@mbp-siarhei''
    ];
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
