{ pkgs, username, ... }:
{
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin
    "syncsupprep"
    ''
      sudo chown -R ${username}:users /home/${username}/projects/srv
    '')
  ];
}
