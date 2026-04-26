{
  imports = [
    # Host specific config
    ./hardware.nix
    ./hardware-gen.nix
    ./env.nix
    ./syncthing.nix

    # Users
    ./../../modules/users/server-default.nix

    # System boot
    ./../../modules/boot.nix

    # System services
    ./../../modules/services.nix
    ./../../modules/ssh.nix
    ./../../modules/security.nix
    ./../../modules/server/network-wifi.nix

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
}
