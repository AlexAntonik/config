{ pkgs, host, ... }:
let
  cursorTheme = "Bibata-Modern-Ice";
  cursorSize = 24;
in
{
  hm.${host.username} = {
    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };

    home.pointerCursor = {
      enable = true;
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = cursorTheme;
      size = cursorSize;
    };
  };

  environment.variables = {
    XCURSOR_THEME = cursorTheme;
    XCURSOR_SIZE = toString cursorSize;
    HYPRCURSOR_THEME = cursorTheme;
    HYPRCURSOR_SIZE = toString cursorSize;
  };

  environment.systemPackages = with pkgs; [
    bibata-cursors
  ];
}
