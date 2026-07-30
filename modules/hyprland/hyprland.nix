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
      ".config/hypr/hypr_general.lua".source =
        mkOutOfStoreSymlink "${host.flakePath}/modules/hyprland/hypr_general.lua";
      ".config/hypr/hypr_binds.lua".source =
        mkOutOfStoreSymlink "${host.flakePath}/modules/hyprland/hypr_binds.lua";
      ".config/hypr/hypr_rules.lua".source =
        mkOutOfStoreSymlink "${host.flakePath}/modules/hyprland/hypr_rules.lua";
    };

    systemd.user.targets.hyprland-session.Unit.Wants = [
      "xdg-desktop-autostart.target"
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      systemd = {
        enable = true;
        enableXdgAutostart = true;
        variables = [ "--all" ];
      };

      xwayland = {
        enable = true;
      };
      extraConfig = ''
        require("hypr_general")
        require("hypr_binds")
        require("hypr_rules")
      '';
    };
  };
}
