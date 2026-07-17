{ host, config, ... }:
{
  imports = [
    ./sectets/user-secrets.nix
    ./user-default.nix
  ];
  users.users.${host.username} = {
    extraGroups = [
      "input"
      "wheel"
    ];
    hashedPasswordFile = config.age.secrets.desktop-user-pwd-hash.path;
  };
}
