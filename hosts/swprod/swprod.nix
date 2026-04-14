{
  pkgs,
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

    # Users
    ./../../modules/users/swprod.nix

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

  services.openssh = {
    settings = {
      PasswordAuthentication = lib.mkForce false; # Override from ssh.nix
    };
  };
}
