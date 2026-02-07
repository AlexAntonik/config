{ inputs, env, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit inputs env;
    };
    users.${env.username} = {
      home = {
        username = "${env.username}";
        homeDirectory = "/home/${env.username}";

        stateVersion = "${env.stateVersion}";
      };
    };
  };
}
