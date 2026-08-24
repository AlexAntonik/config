{
  lib,
  config,
  options,
  inputs,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  options = {
    homeManager.enable = lib.mkEnableOption "home-manager integration";
    hm = lib.mkOption {
      type = lib.types.attrsOf lib.types.deferredModule;
      description = "home-manager.users.<username> alias";
    };
  };

  config = lib.mkMerge [
    {
      warnings = lib.optional (options.hm.definitions != [ ] && !config.homeManager.enable) ''
        config.hm defined without home-manager NixOS module.
        Enable home-manager to apply hm configuration ' homeManager.enable = true; '
      '';
    }
    (lib.mkIf config.homeManager.enable {
      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        extraSpecialArgs = {
          inherit inputs;
          host = config.host;
        };
        users = config.hm;
      };
    })
  ];
}
