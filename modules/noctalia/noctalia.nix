{
  inputs,
  host,
  mkSymlinks,
  ...
}:
{
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.tuned.enable = true;
  services.upower.enable = true;
  nix.settings = {
    substituters = [ "https://noctalia.cachix.org" ];
    trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
  system.activationScripts = mkSymlinks "noctalia" {
    "/home/${host.username}/.config/noctalia/settings.toml" =
      "${host.flakePath}/modules/noctalia/settings.toml";
  };
  home = {
    imports = [ inputs.noctalia.homeModules.default ];
    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      # plugins = {
      #   sources = [
      #     {
      #       enabled = true;
      #       name = "Official Noctalia Plugins";
      #       url = "https://github.com/noctalia-dev/noctalia-plugins";
      #     }
      #   ];
      #   states = {
      #     timer = {
      #       enabled = true;
      #       sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
      #     };
      #     screen-recorder = {
      #       enabled = true;
      #       sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
      #     };
      #     tailscale = {
      #       enabled = true;
      #       sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
      #     };
      #   };
      #   version = 1;
      # };
    };
  };
}
