{
  inputs,
  pkgs,
  host,
  symlink,
  ...
}:
{
  nix.settings = {
    substituters = [ "https://noctalia.cachix.org" ];
    trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
  environment.systemPackages = [
    inputs.noctaliav5.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
  home = {
    imports = [ inputs.noctalia.homeModules.default ];
    home.file.".config/noctalia/settings.json".source =
      symlink "/home/${host.username}/config/modules/noctalia/settings.json";
    programs.noctalia-shell = {
      enable = true;
      plugins = {
        sources = [
          {
            enabled = true;
            name = "Official Noctalia Plugins";
            url = "https://github.com/noctalia-dev/noctalia-plugins";
          }
        ];
        states = {
          timer = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          screen-recorder = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          tailscale = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
        };
        version = 1;
      };
    };
  };
}
