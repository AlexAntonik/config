{ ... }:
{
  imports = [
    ./config.nix
    ./networking.nix
    ./hardware-configuration.nix
    ./host-packages.nix
    ./syncthing.nix
  ];
}
