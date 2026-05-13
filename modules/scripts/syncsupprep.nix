{ pkgs, host, ... }:
let
  user = host.username;
in
{
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "syncsupprep" ''
      sudo chown -R ${user}:users /home/${user}/projects/srv
    '')
  ];
}
