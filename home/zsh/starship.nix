{ pkgs, ... }:

{
  programs.starship = {
    enable = true;
    package = pkgs.starship;
    settings = pkgs.lib.importTOML ./starship.toml;
  };
}
