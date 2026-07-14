{
  inputs,
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
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.tuned.enable = true;
  services.upower.enable = true;
  nix.settings = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
  system.activationScripts = mkSymlinks "noctalia" {
    "/home/${host.username}/.local/state/noctalia/settings.toml" =
      "${host.flakePath}/modules/noctalia/settings.toml";
  };
  hm.${host.username} = {
    imports = [ inputs.noctalia.homeModules.default ];
    programs.noctalia = {
      enable = true;
      systemd.enable = true;
    };
  };
}
