{
  inputs,
  username,
  stateVersion,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit inputs;
    };
    users.${username} = {
      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";

        stateVersion = "${stateVersion}";
      };
    };
  };
}
