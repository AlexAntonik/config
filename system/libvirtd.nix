{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Virtualization
    libvirt # Virtualization library
    virt-viewer # Virtual machine viewer
  ];
  programs.virt-manager.enable = true; # Virtual machine manager
  virtualisation.libvirtd.enable = true;
}