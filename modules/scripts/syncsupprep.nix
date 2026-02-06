{ pkgs, env }:

pkgs.writeShellScriptBin "syncsupprep" ''
  sudo chown -R ${env.username}:users /home/${env.username}/projects/srv
''