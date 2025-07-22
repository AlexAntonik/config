{ ... }:
{
  imports = [
    ./users.nix
    ./drivers.nix
    ./configuration.nix
    ./networking.nix
    ./hardware-configuration.nix
    ./host-packages.nix
  ];
}
