{
  modulesPath,
  pkgs,
  ...
}: {
  imports = [(modulesPath + "/profiles/qemu-guest.nix")];
  boot.loader.grub.device = "/dev/vda";
  #  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "xen_blkfront" "vmw_pvscsi"];
  boot.tmp.cleanOnBoot = true;
  boot.initrd.kernelModules = ["nvme"];
  fileSystems."/" = {
    device = "/dev/vda1";
    fsType = "ext4";
  };
  zramSwap.enable = true;
}
