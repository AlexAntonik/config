{ host, ... }:
{  
  users.mutableUsers = true;
  users.users.${host.username} = {
    isNormalUser = true;
    description = host.gitUsername;
    extraGroups = [
      "input"
      "wheel"
    ]; 
    ignoreShellProgramCheck = true;
  };
  nix.settings.allowed-users = [ host.username ];
}
