{ pkgs, host, ... }:
let
  inherit (import ../../hosts/${host}/env.nix) keyboardLayout;
in
{
  # Appimage Support
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    configPackages = [ pkgs.hyprland ];
  };
  services = {
    libinput.enable = true;
    gvfs.enable = true;
    xserver = {
      enable = false; # Для Wayland/Hyprland
      xkb = {
        layout = "${keyboardLayout}";
        variant = "";
        options = "grp:win_space_toggle"; # also need to be changed in hyprland config
      };
    };
    gnome.gnome-keyring.enable = true;
  };
}
