{
  lib,
  config,
  options,
  ...
}:
{
  options = {
    env = lib.mkOption {
      type = lib.types.attrs;
      description = "Host enviroment variables accessible in all modules";
    };
    home = lib.mkOption {
      type = lib.types.deferredModule;
      description = "home-manager.users.<username> alias";
    };
  };

  config = {
    _module.args = config.env;
  }
  // lib.optionalAttrs (options ? home-manager) {
    home-manager.users."${config.env.username}" = config.home;
    home-manager.extraSpecialArgs = config.env;
  };
}
