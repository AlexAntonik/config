{ pkgs, ... }:
{
  # Styling Options
  stylix = {
    enable = true;
    # image = ./../home/hyprland/wallpapers/mountains.jpg;
    base16Scheme = {
      base00 = "0d0d0d";
      base01 = "1a1a1a";
      base02 = "2d2d2d";
      base03 = "4a4a4a";
      base04 = "6a6a6a";
      base05 = "b8b8b8";
      base06 = "d4d4d4";
      base07 = "e8e8e8";
      base08 = "a8a8a8";
      base09 = "9a9a9a";
      base0A = "8c8c8c";
      base0B = "989898";
      base0C = "949494";
      base0D = "a0a0a0";
      base0E = "9c9c9c";
      base0F = "888888";
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

        # package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        package = pkgs.nerd-fonts.jetbrains-mono; # Unstable channel update
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
