{
  pkgs,
  env,
  ...
}:
{
  imports = [
    ./hardware.nix # User defined hardware configuration
    ./hardware-gen.nix # Nix generated hardware configuration
    ./env.nix # Host variables

    ./../../modules/boot.nix
    # ./../../modules/fonts.nix
    ./../../modules/srv/network-wifi.nix
    ./../../modules/nh.nix # Nix helper
    ./../../modules/utilities.nix # TUI utilities and tools
    ./../../modules/ssh.nix # SSH configuration
    ./../../modules/security.nix # Security settings (Polkit, RTkit, PAM)
    ./../../modules/services.nix # General services (Journald, Fstrim, etc.)
    ./../../modules/starship.nix
    ./../../modules/tailscale.nix # Tailscale service
    ./../../modules/git.nix
    ./../../modules/secrets/sops.nix
    ./../../modules/time.nix
    ./../../modules/lazygit.nix # Git tui
    ./../../modules/htop.nix # htop
    ./../../modules/bat.nix # More cute cat
    ./../../modules/nix.nix
    ./../../modules/options.nix # Host options glue
    ./../../modules/docker.nix
    ./../../modules/zsh.nix # Shell system wide
    ./../../modules/zoxide.nix # cd alternative super nice
    ./../../modules/nvf.nix # vim
    # ./cloudflared.nix
    ./syncthing.nix

  ];

  programs = {
    # adb.enable = true; # Android Debug Bridge
    # amnezia-vpn.enable = true;
  };
  environment.systemPackages = [
    (import ./../../modules/scripts/syncsupprep.nix {
      inherit pkgs;
      inherit env;
    })
  ];

  # prevent load when lid closed
  services.logind.lidSwitch = "ignore";

  users.mutableUsers = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.${env.username} = {
    openssh.authorizedKeys.keys = [
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILUSJwUYV0e+h3Rj4+YvrsqHuolIh45KHg9Lttid1+KI alex@alex''
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
