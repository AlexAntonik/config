{ pkgs, ... }:
{
  # Styling Options
  stylix = {
    enable = true;
    base16Scheme = {
      base00 = "1d1d1d";
      base01 = "484848";
      base02 = "6c6c6c";
      base03 = "9b9b9b";
      base04 = "b7b7b7";
      base05 = "e2e2e2";
      base06 = "e9e9e9";
      base07 = "ebebeb";
      base08 = "8f8f8f";
      base09 = "919191";
      base0A = "919191";
      base0B = "919191";
      base0C = "919191";
      base0D = "8f8f8f";
      base0E = "8d8d8d";
      base0F = "8c8c8c";
    };
    polarity = "dark";
    opacity.terminal = 1.0;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
    #System targets
    targets = {
      plymouth.enable = false;
      grub.enable = false;
      console.enable = false;
    };

    fonts = {
      monospace = {

        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        # package = pkgs.nerd-fonts.jetbrains-mono;  # Unstable channel update
        name = "JetBrains Mono";
      };
      sansSerif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      serif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      sizes = {
        applications = 12;
        terminal = 15;
        desktop = 11;
        popups = 12;
      };
    };
  };
}
