{
  lib,
  pkgs,
  config,
  options,
  ...
}:
let
  symlink = import ./symlink.nix { inherit lib pkgs; };
in
{
  options = {
    host = lib.mkOption {
      type = lib.types.attrs;
      description = "Host environment variables accessible in all modules";
    };
    home = lib.mkOption {
      type = lib.types.deferredModule;
      description = "home-manager.users.<username> alias";
    };
  };

  config = lib.mkMerge [
    {
      _module.args = {
        host = config.host;
        inherit symlink;
      };
    }
    (lib.optionalAttrs (options ? home-manager) {
      home-manager.users.${config.host.username} = config.home;
      home-manager.extraSpecialArgs = {
        host = config.host;
        inherit symlink;
      };
    })
  ];
}
