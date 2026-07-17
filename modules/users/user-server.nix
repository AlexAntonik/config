{ host, config, ... }:
{
  imports = [
    ./user-default.nix
    ./../secrets/agenix.nix
  ];
  age.secrets.server-user-pwd-hash = {
    file = ./server-user-pwd-hash.age;
    owner = host.username;
  };
  users.users.${host.username} = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILUSJwUYV0e+h3Rj4+YvrsqHuolIh45KHg9Lttid1+KI alex@alex"
    ];
    extraGroups = [
      "wheel"
    ];
    hashedPasswordFile = config.age.secrets.server-user-pwd-hash.path;
  };
}
