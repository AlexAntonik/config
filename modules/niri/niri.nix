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
  system.activationScripts = mkSymlinks "niri" host {
    ".config/niri/config.kdl" = "modules/niri/config.kdl";
  };
}
