{
  pkgs,
  username,
  gitUsername,
  lib,
  ...
}:
{
  imports = [
    # Host specific config
    ./hardware-configuration.nix
    ./networking.nix
    ./env.nix
    ./syncthing.nix

    # System services
    ./../../modules/services.nix
    ./../../modules/ssh.nix
    ./../../modules/security.nix

    # Tools & utilities
    ./../../modules/utilities.nix
    ./../../modules/lazygit.nix
    ./../../modules/htop.nix
    ./../../modules/bat.nix
    ./../../modules/docker.nix

    # Development & shell
    ./../../modules/git.nix
    ./../../modules/nvf.nix
    ./../../modules/zsh.nix
    ./../../modules/zoxide.nix
    ./../../modules/starship.nix

    # Nix related
    ./../../modules/nix.nix
    ./../../modules/nh.nix
    ./../../modules/options.nix

    # Services & ops
    ./../../modules/srv/bkp.nix
    ./../../modules/srv/supabase-restart.nix

    # Config & misc
    ./../../modules/time.nix
    ./../../modules/secrets/sops.nix

    # Scripts
    ./../../modules/scripts/syncsupprep.nix
  ];

  programs = {
    # adb.enable = true; # Android Debug Bridge
  };
  environment.systemPackages = with pkgs; [
    supabase-cli
    postgresql
  ];

  users.mutableUsers = true;
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
