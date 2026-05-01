{ pkgs, username, ... }:
{
  users.users.${username}.extraGroups = [
    "kvm"
    "adbusers"
  ];
  environment.systemPackages = with pkgs; [
    android-sdk
    android-tools
    android-studio
  ];
}
