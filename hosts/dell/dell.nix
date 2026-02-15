{
  username,
  gitUsername,
  ...
}:
{
  imports = [
    # Host specific config
    ./hardware.nix
    ./hardware-gen.nix
    ./env.nix
    ./syncthing.nix

    # System boot
    ./../../modules/boot.nix

    # System services
    ./../../modules/services.nix
    ./../../modules/ssh.nix
    ./../../modules/security.nix
    ./../../modules/srv/network-wifi.nix

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
    ./../../modules/nh.nix
    ./../../modules/nix.nix
    ./../../modules/options.nix

    # Config & misc
    ./../../modules/time.nix
    ./../../modules/secrets/sops.nix
    ./../../modules/tailscale.nix

    # Scripts
    ./../../modules/scripts/syncsupprep.nix
  ];

  programs = {
    # adb.enable = true; # Android Debug Bridge
    # amnezia-vpn.enable = true;
  };
  environment.systemPackages = [
  ];

  # ignore closed lid
  services.logind.settings.Login.HandleLidSwitch = "ignore";

  users.mutableUsers = true;
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
  nix.settings.allowed-users = [ "${username}" ];
}
