{
  host,
  pkgs,
  mkSymlinks,
  ...
}:
{
  environment.systemPackages = [
    pkgs.satty # Screenshot editing tool
    pkgs.wl-clipboard # Clipboard manager neded for satty clipboard support
  ];

  system.activationScripts = mkSymlinks "noctalia" {
    "/home/${host.username}/.local/state/noctalia/settings.toml" =
      "${host.flakePath}/modules/noctalia/settings.toml";
  };

  programs.noctalia = {
    enable = true;
    package = pkgs.noctalia;
    systemd.enable = true;
    recommendedServices.enable = true;
  };
}
