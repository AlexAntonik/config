{ env, pkgs, ... }:
{
  systemd.services.docker-compose-maintenance = {
    description = "Docker Compose Maintenance Service";
    serviceConfig = {
      Type = "oneshot";
      StandardOutput = "journal";
      StandardError = "journal";
    };
    script = ''
      echo "Starting Docker Compose maintenance at $(date)"
      
      COMPOSE_DIR="/home/${env.username}/projects/srv"
      
      if [ -d "$COMPOSE_DIR" ]; then
        echo "Stopping Docker Compose services..."
        cd $COMPOSE_DIR
        ${pkgs.docker}/bin/docker compose down
        echo "Docker Compose services stopped at $(date)"
      else
        echo "Error: Docker Compose file not found at $COMPOSE_DIR"
        exit 1
      fi
      
      echo "Changing file ownership..."
      chown -R ${env.username}:users /home/${env.username}/projects/srv
      echo "File ownership changed to ${env.username}:users for /home/${env.username}/projects/srv"
      
      # Forced syncthing rescan, 
      # but this pkgs not so popular,
      # even than briefly checked source code, off by now
      # ${pkgs.stc-cli}/bin/stc --homedir "/home/${env.username}/.config/syncthing" rescan "Prod"

      echo "Waiting 4 minutes..."
      sleep 240
      echo "Wait completed at $(date)"
      
      if [ -d "$COMPOSE_DIR" ]; then
        echo "Starting Docker Compose services..."
        cd $COMPOSE_DIR
        ${pkgs.docker}/bin/docker compose up -d
        echo "Docker Compose services started at $(date)"
      else
        echo "Error: Docker Compose file not found at $COMPOSE_DIR"
        exit 1
      fi
      
      echo "Docker Compose maintenance completed at $(date)"
    '';
  };


  systemd.timers.docker-compose-maintenance = {
    description = "Run Docker Compose Maintenance";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "03:00";
      Persistent = true;
    };
  };
}