{
  host,
  pkgs,
  mkOutOfStoreSymlink,
  ...
}:
{
  environment.systemPackages = [
    pkgs.satty # Screenshot editing tool
    pkgs.wl-clipboard # Clipboard manager neded for satty clipboard support
  ];
  hm.${host.username}.home.file.".local/state/noctalia/settings.toml" = {
    source = mkOutOfStoreSymlink "${host.flakePath}/modules/noctalia/settings.toml";
    force = true;
  };

  programs.noctalia = {
    enable = true;
    package = pkgs.noctalia;
    systemd.enable = true;
    recommendedServices.enable = true;
  };
}
