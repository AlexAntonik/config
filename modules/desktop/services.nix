{ pkgs, ... }:
{
  # Appimage Support
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
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
  };
  services = {
    libinput.enable = true;
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
  };
}
