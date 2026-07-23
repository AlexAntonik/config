{
  pkgs,
  host,
  mkSymlinks,
  ...
}:
{
  programs.hyprland.enable = true;
  hm.${host.username} = {
    home.packages = [
      pkgs.hyprpicker
    ];
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

  system.activationScripts = mkSymlinks "hyprland" {
    "/home/${host.username}/.config/hypr/hypr_general.lua" =
      "${host.flakePath}/modules/hyprland/hypr_general.lua";
    "/home/${host.username}/.config/hypr/hypr_binds.lua" =
      "${host.flakePath}/modules/hyprland/hypr_binds.lua";
    "/home/${host.username}/.config/hypr/hypr_rules.lua" =
      "${host.flakePath}/modules/hyprland/hypr_rules.lua";
  };
}
