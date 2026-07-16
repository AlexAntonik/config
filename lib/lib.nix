{
  lib,
  config,
  options,
  ...
}:
let
  hostSubmodule = import ./host.nix { inherit lib; };
  mkSymlinks = import ./symlinks.nix { inherit lib; };
in
{
  options = {
    host = lib.mkOption {
      type = hostSubmodule;
      description = "Host environment variables accessible in all modules";
    };
    hm = lib.mkOption {
      type = lib.types.attrsOf lib.types.deferredModule;
      description = "home-manager.users.<username> alias";
    };
  };

  config = lib.mkMerge [
    {
      _module.args = {
        host = config.host;
        inherit mkSymlinks;
      };
    }
    {
      warnings = lib.optional (!(options.hm.definitions == [ ] || (options ? home-manager))) ''
        config.home defined without home-manager. Import modules/home-manager.nix if home config needed.
      '';
    }
    (lib.optionalAttrs (options ? home-manager) {
      home-manager.users = config.hm;
    })
  ];
}
