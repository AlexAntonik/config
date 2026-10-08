{ inputs, ... }: { host, config, lib, ... }:
let
  withArgs = import ../../lib/importApplyWithArgs.nix {
    inherit lib;
    staticArgs = { inherit inputs; };
  };
in
{
  imports = map withArgs [
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
