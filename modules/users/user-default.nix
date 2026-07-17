
{ host, ... }:
{
  users.users.root.hashedPassword = "!";
  users.mutableUsers = false;
  users.users.${host.username} = {
    isNormalUser = true;
    description = host.gitUsername;
    ignoreShellProgramCheck = true;
  };
  nix.settings.allowed-users = [ host.username ];
}