{ pkgs, ... }:
{
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
      base08 = "aaaaaa";
      base09 = "a2a2a2";
      base0A = "9a9a9a";
      base0B = "929292";
      base0C = "8a8a8a";
      base0D = "828282";
      base0E = "7a7a7a";
      base0F = "727272";
    };
    polarity = "dark";
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
        package = pkgs.nerd-fonts.jetbrains-mono;
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
