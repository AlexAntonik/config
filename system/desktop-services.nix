{ pkgs, host, ... }:
let
  inherit (import ../../hosts/${host}/variables.nix) keyboardLayout;
in
{
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    configPackages = [ pkgs.hyprland ];
  };
  services = {
    libinput.enable = true;
    gvfs.enable = true;
    xserver = {
      enable = false;  # Для Wayland/Hyprland
      xkb = {
        layout = "${keyboardLayout}";
        variant = "";
        options = "grp:win_space_toggle"; # also need to be changed in hyprland config
      };
    };
    gnome.gnome-keyring.enable = true;
  };
}