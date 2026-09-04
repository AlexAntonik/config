{
  pkgs,
  host,
  mkOutOfStoreSymlink,
  ...
}:
{
  programs.hyprland.enable = true;
  hm.${host.username} = {
    home.packages = [
      pkgs.hyprpicker
    ];

    home.file = {
      ".config/hypr/hypr_general.lua" = {
        source = mkOutOfStoreSymlink "${host.flakePath}/modules/hyprland/hypr_general.lua";
        force = true;
      };
      ".config/hypr/hypr_binds.lua" = {
        source = mkOutOfStoreSymlink "${host.flakePath}/modules/hyprland/hypr_binds.lua";
        force = true;
      };
      ".config/hypr/hypr_rules.lua" = {
        source = mkOutOfStoreSymlink "${host.flakePath}/modules/hyprland/hypr_rules.lua";
        force = true;
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd = {
        enable = true;
        enableXdgAutostart = true;
        variables = [ "--all" ];
      };

      extraConfig = ''
        require("hypr_general")
        require("hypr_binds")
        require("hypr_rules")
      '';
    };
  };
}
