{
  lib,
  config,
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
      warnings = lib.optional (builtins.attrNames config.hm != [ ] && !config.homeManager.enable) ''
        config.hm is defined but home-manager integration is disabled.
        Enable it with: homeManager.enable = true;
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
        users = lib.mkMerge [
          { ${config.host.username}.home.stateVersion = config.host.stateVersion; }
          config.hm
        ];
      };
    })
  ];
}
