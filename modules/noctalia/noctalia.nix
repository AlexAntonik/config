{ host, mkOutOfStoreSymlink, ... }:
{
  hm.${host.username}.home.file.".local/state/noctalia/settings.toml" = {
    source = mkOutOfStoreSymlink "${host.flakePath}/modules/noctalia/settings.toml";
    force = true;
  };

  programs.noctalia = {
    enable = true;
    systemd.enable = true;
    recommendedServices.enable = true;
  };
}
