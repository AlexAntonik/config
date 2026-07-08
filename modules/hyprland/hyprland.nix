{
  pkgs,
  host,
  mkSymlinks,
  ...
}:
{
  programs.hyprland.enable = true;
  xdg.portal = {
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    configPackages = [ pkgs.hyprland ];
  };

  home.xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
    ];
    config.common.default = [ "hyprland" ];
  };
  home = {
    home.packages = [
      pkgs.hyprpicker
    ];

    systemd.user.targets.hyprland-session.Unit.Wants = [
      "xdg-desktop-autostart.target"
    ];
    services.hyprpolkitagent.enable = true;
    wayland.windowManager.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      systemd = {
        enable = true;
        enableXdgAutostart = true;
        variables = [ "--all" ];
      };

      xwayland = {
        enable = true;
      };
    };
  };

  system.activationScripts = mkSymlinks "hyprland" {
    "/home/${host.username}/.config/hypr/hyprland.lua" = "${host.flakePath}/modules/hyprland/hyprland.lua";
  };
}
