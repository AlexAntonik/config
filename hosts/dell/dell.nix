{
  host = {
    # Locals
    username = "alex";
    hostname = "dell"; # Must be the same as dir name

    gitUsername = "AlexAntonik";
    gitEmail = "antonikavv@gmail.com";

    timeZone = "Europe/Minsk";
    stateVersion = "23.11";
  };

  imports = [
    # Host specific config
    ./hardware.nix
    ./hardware-gen.nix
    ./syncthing.nix
    ./secrets/secrets.nix

    # Users
    ./../../modules/users/server-user.nix

    # System boot
    ./../../modules/boot.nix

    # System services
    ./../../modules/logs.nix
    ./../../modules/ssh.nix
    ./../../modules/security.nix
    ./../../modules/networking/base-network.nix

    # Tools & utilities
    ./../../modules/utilities.nix
    ./../../modules/lazygit.nix
    ./../../modules/bat.nix
    ./../../modules/docker.nix

    # Development & shell
    ./../../modules/git.nix
    ./../../modules/nvf.nix
    ./../../modules/zsh.nix
    ./../../modules/zoxide.nix
    ./../../modules/starship.nix

    # Config & misc
    ./../../modules/nix.nix
    ./../../modules/time.nix
    ./../../modules/tailscale.nix

    # Scripts
    ./../../modules/scripts/syncsupprep.nix
  ];

  programs = {
    # amnezia-vpn.enable = true;
  };
  environment.systemPackages = [
  ];

  # ignore closed lid
  services.logind.settings.Login.HandleLidSwitch = "ignore";
}
