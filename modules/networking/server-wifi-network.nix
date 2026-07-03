{
  imports = [ ./base-network.nix ];
  networking.dhcpcd.extraConfig = "noarp";
  networking.dhcpcd.wait = "background";
}
