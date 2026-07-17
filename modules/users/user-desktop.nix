{ host, config, ... }:
{
  imports = [
    ./../secrets/agenix.nix
    ./user-default.nix
  ];
  age.secrets.desktop-user-pwd-hash.file = ./secrets/desktop-user-pwd-hash.age;
  users.users.${host.username} = {
    extraGroups = [
      "input"
      "wheel"
    ];
    hashedPasswordFile = config.age.secrets.desktop-user-pwd-hash.path;
  };
}
