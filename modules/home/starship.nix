{ pkgs, ... }:

{
  programs.starship = {
    enable = true;
    package = pkgs.starship;
  };
}
