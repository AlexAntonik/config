{
  lib,
  config,
  options,
  ...
}:
let
  symlinks = import ./symlinks.nix { inherit lib; };

  hostSubmodule = lib.types.submodule (hostCfg: {
    options = {
      username = lib.mkOption { type = lib.types.str; };
      hostname = lib.mkOption { type = lib.types.str; };
      flakePath = lib.mkOption {
        type = lib.types.str;
        default = "/home/${hostCfg.config.username}/config";
        description = "Absolute path where this flake is checked out on this machine.";
      };
      gitUsername = lib.mkOption { type = lib.types.str; };
      gitEmail = lib.mkOption { type = lib.types.str; };
      timeZone = lib.mkOption { type = lib.types.str; };
      defaultLocale = lib.mkOption {
        type = lib.types.str;
        default = "en_US.UTF-8";
      };
      extraLocaleSettings = lib.mkOption {
        type = lib.types.str;
        default = "en_US.UTF-8";
      };
      stateVersion = lib.mkOption { type = lib.types.str; };
      keyboardLayout = lib.mkOption {
        type = lib.types.str;
        default = "us";
      };

      # Device IDs/settings for some features
      mainMonitor = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
      touchpadID = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
      keyboardLightID = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
      keyboardScreenOFFLightID = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
      languageLightID = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
      kbdIdleTimeout = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
    };
  });
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
    (lib.optionalAttrs (options ? home-manager) {
      home-manager.users.${config.host.username} = config.home;
    })
  ];
}
