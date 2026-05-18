{
  inputs,
  pkgs,
  host,
  ...
}:
{
  environment.systemPackages = [
    inputs.nirimod.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
  programs.niri.enable = true;
  home =
    { config, ... }:
    {
      home.file.".config/niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink "/home/${host.username}/config/modules/niri/config.kdl";
    };
}