{ pkgs, username, ... }:
{
  virtualisation.libvirtd.enable = true;
  users.users.${username}.extraGroups = [ "libvirtd" ];
  environment.systemPackages = with pkgs; [
    # Virtualization
    libvirt # Virtualization library
    virt-viewer # Virtual machine viewer
  ];
  programs.virt-manager.enable = true; # Virtual machine manager
  home.dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}