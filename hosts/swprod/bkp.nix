{ host, pkgs, ... }:
{
  systemd.services.docker-compose-maintenance = {
    description = "Docker Compose Maintenance Service";
    path = [
      pkgs.postgresql
      pkgs.coreutils
      pkgs.findutils
    ];
    serviceConfig = {
      Type = "oneshot";
      StandardOutput = "journal";
      StandardError = "journal";
    };
    script = ''
      echo "Starting Docker Compose maintenance at $(date)"

      COMPOSE_DIR="/home/${host.username}/projects/srv"

      if [ -d "$COMPOSE_DIR" ]; then
        echo "Stopping Docker Compose services..."
        cd $COMPOSE_DIR
        ${pkgs.bash}/bin/bash bkp.sh
        ${pkgs.docker}/bin/docker compose down
        echo "Docker Compose services stopped at $(date)"
      else
        echo "Error: Docker Compose file not found at $COMPOSE_DIR"
        exit 1
      fi

      echo "Waiting a minute"
      sleep 60
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
  systemd.sockets.postgres-bkp = {
    listenStreams = [ "127.0.0.1:50432" ];
    socketConfig.Service = "docker-compose-maintenance.service";
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
