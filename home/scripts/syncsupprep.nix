{ pkgs, username }:

pkgs.writeShellScriptBin "syncsupprep" ''
  sudo chown -R ${username}:users /home/${username}/projects/srv
''