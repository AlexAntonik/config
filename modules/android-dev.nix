{ pkgs, host, ... }:
{
  users.users.${host.username}.extraGroups = [
    "kvm"
    "adbusers"
  ];
  environment.systemPackages = with pkgs; [
    androidsdk
    android-tools
    android-studio
  ];
}
