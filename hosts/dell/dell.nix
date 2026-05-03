{
  env = {
    # Locals
    username = "alex";
    host = "dell"; # Must be the same as dir name

    gitUsername = "AlexAntonik";
    gitEmail = "antonikavv@gmail.com";

    # Time and Locale Settings
    timeZone = "Europe/Minsk";
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = "en_US.UTF-8";

    stateVersion = "23.11";
  };

  imports = [
    # Host specific config
    ./hardware.nix
    ./hardware-gen.nix
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
    # amnezia-vpn.enable = true;
  };
  environment.systemPackages = [
  ];

  # ignore closed lid
  services.logind.settings.Login.HandleLidSwitch = "ignore";
}
