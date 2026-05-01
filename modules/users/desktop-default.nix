{ username, gitUsername, ... }:
{  
  users.mutableUsers = true;
  users.users.${username} = {
    isNormalUser = true;
    description = "${gitUsername}";
    extraGroups = [
      "docker"
      "libvirtd"
      "input"
      "lp"
      "networkmanager"
      "scanner"
      "wheel"
    ]; 
    ignoreShellProgramCheck = true;
  };
  nix.settings.allowed-users = [ "${username}" ];
}
