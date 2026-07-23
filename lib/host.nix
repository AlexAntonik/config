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
    };
  });
in
hostSubmodule
