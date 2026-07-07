{
  lib,
  config,
  options,
  ...
}:
let
  symlinks = import ./symlinks.nix { inherit lib; };
  hostSubmodule = import ./host.nix { inherit lib; };
in
{
  options = {
    host = lib.mkOption {
      type = hostSubmodule;
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
        inherit (symlinks) mkSymlinks;
      };
    }
    {
      warnings = lib.optional (!(options.home.definitions == [ ] || (options ? home-manager))) ''
        config.home defined without home-manager. Import modules/home-manager.nix if home config needed.
      '';
    }
    (lib.optionalAttrs (options ? home-manager) {
      home-manager.users.${config.host.username} = config.home;
    })
  ];
}
