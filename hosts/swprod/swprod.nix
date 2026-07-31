{ pkgs, lib, ... }:
{
  host = {
    username = "user";
    gitUsername = "AlexAntonik";
    gitEmail = "antonikavv@gmail.com";

    timeZone = "Europe/Minsk";
    stateVersion = "26.05";
  };

  imports = [
    # Host specific config
    ./hardware-configuration.nix
    ./networking.nix
    ./syncthing.nix
    ./bkp.nix

    # Users
    ./user-swprod.nix

    # System services
    ./../../modules/logs.nix
    ./../../modules/ssh.nix
    ./../../modules/security.nix

    # Tools & utilities
    ./../../modules/utilities.nix
    ./../../modules/lazygit.nix
    ./../../modules/bat.nix
    ./../../modules/docker.nix

    # Development & shell
    ./../../modules/git.nix
    ./../../modules/nvim/nvim-base.nix
    ./../../modules/zsh.nix
    ./../../modules/zoxide.nix
    ./../../modules/starship.nix


    # Config & misc
    ./../../modules/nix.nix
    ./../../modules/time.nix
  ];
  nix.settings.max-jobs = lib.mkForce 2;
  environment.systemPackages = with pkgs; [
    supabase-cli
    postgresql
  ];
}
