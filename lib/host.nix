{ lib }:
let
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
hostSubmodule
