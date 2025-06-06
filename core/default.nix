{
  inputs,
  ...
}:
{
  imports = [
    ./boot.nix
    ./fonts.nix
    ./hardware.nix
    ./protonvpnfix.nix 
    ./network.nix
    ./nh.nix
    ./packages.nix
    ./services.nix
    ./starship.nix
    ./git.nix
    ./steam.nix
    ./stylix.nix
    ./system.nix
    ./user.nix
    ./virtualisation.nix
    inputs.stylix.nixosModules.stylix
  ];
}
