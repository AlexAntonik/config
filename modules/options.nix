{
  lib,
  config,
  options,
  ...
}:
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
  
  config = lib.mkMerge [
    {
      _module.args = {
        home = config.home;
        env = config.env;
      };
    }

    (lib.optionalAttrs (options ? home-manager) {
      home-manager.users."${config.env.username}" = config.home;
    })
  ];
}
