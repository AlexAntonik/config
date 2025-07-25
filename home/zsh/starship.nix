{ pkgs, ... }:

{
  programs.starship = {
    enable = false;
    package = pkgs.starship;
    settings = pkgs.lib.importTOML ./starship.toml;
  };
}
