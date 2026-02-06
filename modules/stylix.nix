{ pkgs, inputs, ... }:
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    enable = true;
    # image = ./../home/hyprland/wallpapers/mountains.jpg;
    base16Scheme = {
      base00 = "#0d0d0d";
      base01 = "#1a1a1a";
      base02 = "#2d2d2d";
      base03 = "#4a4a4a";
      base04 = "#6a6a6a";
      base05 = "#b8b8b8";
      base06 = "#d4d4d4";
      base07 = "#e8e8e8";
      # Accent colors
      base08 = "#c26a6a";
      base09 = "#d08a5e";
      base0A = "#c8b070";
      base0B = "#7fa37a";
      base0C = "#6fa3a3";
      base0D = "#6b8fb8";
      base0E = "#9a7fb0";
      base0F = "#8a6f5a";
    };
    opacity = {
      terminal = 0.8;
      popups = 0.6;
      applications = 0.8;
      desktop = 0.76;
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
      nvf.enable = false;
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

  home.stylix.targets = {
    # hyprland.enable = false;
    bat.enable = false;
    btop.enable = false;
    hyprlock.enable = false;
    yazi.enable = false;
    qt.enable = false;
    vscode.enable = false;
    nvf.enable = false;
    starship.enable = false;
    firefox.enable = false;
    ghostty.enable = false;
  };
}
