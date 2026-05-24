{
  inputs,
  pkgs,
  host,
  mkSymlinks,
  ...
}:
{
  environment.systemPackages = [
    inputs.nirimod.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
  programs.niri.enable = true;
  system.activationScripts = mkSymlinks "niri" {
    "/home/${host.username}/.config/niri/config.kdl" = "${host.flakePath}/modules/niri/config.kdl";
  };
}
