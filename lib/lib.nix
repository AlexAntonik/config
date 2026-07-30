{
  lib,
  config,
  options,
  hostName,
  pkgs,
  ...
}:
let
  hostSubmodule = import ./host.nix { inherit lib; };
  mkOutOfStoreSymlink = # system wide hm alternative
    path:
    let 
      pathStr = toString path;
    in 
    pkgs.runCommandLocal (lib.strings.sanitizeDerivationName (baseNameOf pathStr)) { } ''
      ln -s "${pathStr}" $out
    '';
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
      host.hostName = hostName;
      _module.args = {
        host = config.host;
        inherit mkOutOfStoreSymlink;
      };
    }
    {
      warnings = lib.optional (options.hm.definitions != [ ] && !(options ? home-manager)) ''
        config.home defined without home-manager. Import modules/home-manager.nix if home config needed.
      '';
    }
    (lib.optionalAttrs (options ? home-manager) {
      home-manager.users = config.hm;
    })
  ];
}
