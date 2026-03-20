{ username, gitUsername, ... }:
{
  imports = [ ../secrets/sops.nix ];
  
  users.mutableUsers = false;
  users.users.${username} = {
    isNormalUser = true;
    description = "${gitUsername}";
    extraGroups = [
      "adbusers"
      "docker"
      "libvirtd"
      "input"
      "kvm"
      "lp"
      "networkmanager"
      "scanner"
      "wheel"
    ];
    ignoreShellProgramCheck = true;
  };
  nix.settings.allowed-users = [ "${username}" ];
}
