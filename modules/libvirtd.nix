{ pkgs, host, ... }:
{
  virtualisation.libvirtd.enable = true;
  users.users.${host.username}.extraGroups = [ "libvirtd" ];
  environment.systemPackages = [
    # Virtualization
    pkgs.libvirt # Virtualization library
    pkgs.virt-viewer # Virtual machine viewer
  ];
  programs.virt-manager.enable = true; # Virtual machine manager
  home.dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}