{ ... }:
{
  imports = [
    ./users.nix
    ./networking.nix
    ./hardware-configuration.nix
    ./host-packages.nix
  ];
}
