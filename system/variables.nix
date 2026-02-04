{
  flake.nixosModules.variables =
    { lib, config, ... }:
    {
      options = {
        env = lib.mkOption {
          type = lib.types.attrs;
          default = { };
          description = "Host enviroment variables accessible in all modules";
        };
      };
      config._module.args.env = config.env;
    };
}
