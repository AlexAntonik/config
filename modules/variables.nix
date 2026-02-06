{ lib, config, ... }:
{
  options = {
    env= lib.mkOption {
      type = lib.types.attrs;
      default = { };
      description = "Host enviroment variables accessible in all modules"; 
    };
    home = lib.mkOption {
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
