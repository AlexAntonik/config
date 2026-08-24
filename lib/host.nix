{
  lib,
  hostName,
  config,
  ...
}:
{
  options.host = lib.mkOption {
    type = lib.types.submodule {
      options = {
        username = lib.mkOption { type = lib.types.str; };
        hostName = lib.mkOption {
          type = lib.types.str;
          default = hostName;
        };
        flakePath = lib.mkOption {
          type = lib.types.str;
          description = "Absolute path where this flake is checked out on this machine.";
          default = "/home/${config.host.username}/config";
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
    };
    description = "Host environment variables accessible in all modules";
  };

  config._module.args.host = config.host;
}
