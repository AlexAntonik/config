{ pkgs, username, ... }:

let
  chowningScript = ''
    #!/bin/bash
    target_dir="/home/${username}/projects/srv"
    if [ -d "$target_dir" ]; then
      chown -R ${username}:users "$target_dir"
    fi
    exit 0
  '';
in
{
  environment.etc."chowning.sh".text = chowningScript;

  systemd.services.chowning = {
    description = "Recursively chown /home/${username}/projects/srv to ${username}:users";
    script = "${chowningScript}";
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
    path = with pkgs; [ coreutils ];
  };

  systemd.timers.chowning = {
    description = "Timer for chown-srv service";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "1s";
      OnUnitActiveSec = "1s";
    };
  };
}