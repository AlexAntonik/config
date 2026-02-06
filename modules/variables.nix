{ lib, config, ... }:
{
  options = {
    env = lib.mkOption {
      type = lib.types.anything;
      default = { };
      description = "Host enviroment variables accessible in all modules";
    };
    home = lib.mkOption {
      type = lib.types.deferredModule;
      default = { };
      description = "home-manager.users.<username> alias";
    };
  };
  config = {
    _module.args = {
      home = config.home;
      env = config.env;
    };

    home-manager.users."${config.env.username}" = config.home;
  };
}
