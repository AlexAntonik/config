{ host, config, ... }:
{
  imports = [
    ./../secrets/agenix.nix
    ./user-default.nix
  ];
  age.secrets.desktop-user-pwd-hash = {
    file = ./sectets/desktop-user-pwd-hash.age;
    owner = host.username;
  };
  users.users.${host.username} = {
    extraGroups = [
      "input"
      "wheel"
    ];
    hashedPasswordFile = config.age.secrets.desktop-user-pwd-hash.path;
  };
}
