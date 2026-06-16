{ pkgs, host, ... }:
{
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "syncsupprep" ''
      sudo chown -R ${host.username}:users /home/${host.username}/projects/srv
    '')
  ];
}
