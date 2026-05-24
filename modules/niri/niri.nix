{
  inputs,
  pkgs,
  host,
  symlink,
  ...
}:
{
  environment.systemPackages = [
    inputs.nirimod.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
  programs.niri.enable = true;
  home = {
    home.file.".config/niri/config.kdl".source =
      symlink "/home/${host.username}/config/modules/niri/config.kdl";
  };
}
