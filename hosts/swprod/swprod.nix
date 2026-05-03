{
  pkgs,
  lib,
  ...
}:
{
  env = {
    # Flake locals
    username = "user";
    host = "swprod"; # Must be the same as dir name

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
    ./hardware-configuration.nix
    ./networking.nix
    ./syncthing.nix

    # Users
    ./swprod-user.nix

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
    ./../../modules/server/bkp.nix
    ./../../modules/server/supabase-restart.nix

    # Config & misc
    ./../../modules/time.nix
    ./../../modules/secrets/sops.nix

    # Scripts
    ./../../modules/scripts/syncsupprep.nix
  ];

  environment.systemPackages = with pkgs; [
    supabase-cli
    postgresql
  ];

  services.openssh = {
    settings = {
      PasswordAuthentication = lib.mkForce false; # Override from ssh.nix
    };
  };
}
