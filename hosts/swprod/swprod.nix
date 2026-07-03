{ pkgs, lib, ... }:
{
  host = {
    # Flake locals
    username = "user";
    hostname = "swprod"; # Must be the same as dir name

    gitUsername = "AlexAntonik";
    gitEmail = "antonikavv@gmail.com";

    timeZone = "Europe/Minsk";
    stateVersion = "23.11";
  };

  imports = [
    # Host specific config
    ./hardware-configuration.nix
    ./networking.nix
    ./syncthing.nix
    ./secrets/secrets.nix

    # Users
    ./swprod-user.nix

    # System services
    ./../../modules/logs.nix
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

    # Services & ops
    ./../../modules/server/bkp.nix
    ./../../modules/server/supabase-restart.nix

    # Config & misc
    ./../../modules/nix.nix
    ./../../modules/time.nix

    # Scripts
    ./../../modules/scripts/syncsupprep.nix
  ];
  nix.settings.max-jobs = lib.mkForce 2;
  environment.systemPackages = with pkgs; [
    supabase-cli
    postgresql
  ];
}
