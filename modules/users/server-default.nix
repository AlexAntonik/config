{ username, gitUsername, ... }:
{
  users.mutableUsers = true;
  users.users.${username} = {
    openssh.authorizedKeys.keys = [
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILUSJwUYV0e+h3Rj4+YvrsqHuolIh45KHg9Lttid1+KI alex@alex''
    ];
    isNormalUser = true;
    description = "${gitUsername}";
    extraGroups = [
      "wheel"
    ];
    ignoreShellProgramCheck = true;
  };
  nix.settings.allowed-users = [ "${username}" ];
}
