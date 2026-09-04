{ host, pkgs, ... }:
let
  maintenanceScript = pkgs.writeShellScript "docker-compose-maintenance" ''
    set -euo pipefail

    compose_dir="/home/${host.username}/projects/srv"
    backup_dir="$compose_dir/backup"
    docker="${pkgs.docker}/bin/docker"

    if [ ! -d "$compose_dir" ]; then
      echo "Error: $compose_dir not found" >&2
      exit 1
    fi
    cd "$compose_dir"

    timestamp="$(date +%Y%m%d_%H%M%S)"
    dump_file="$backup_dir/database-dump_$timestamp.sql"
    mkdir -p "$backup_dir"

    echo "Dumping database at $(date)"
    trap 'rm -f "$dump_file"' ERR
    "$docker" compose exec -T db pg_dump -U postgres --clean --if-exists >"$dump_file"
    trap - ERR

    # keep the 5 newest dumps; zero-padded timestamps sort lexicographically
    shopt -s nullglob
    dumps=("$backup_dir"/database-dump_*.sql)
    if [ "''${#dumps[@]}" -gt 5 ]; then
      rm -f "''${dumps[@]:0:''${#dumps[@]}-5}"
    fi

    echo "Stopping Docker Compose services at $(date)"
    "$docker" compose down
    echo "Docker Compose services stopped at $(date)"

    echo "Waiting a minute"
    sleep 60

    echo "Starting Docker Compose services at $(date)"
    "$docker" compose up -d
    echo "Docker Compose maintenance completed at $(date)"
  '';
in
{
  systemd.services.docker-compose-maintenance = {
    description = "Docker Compose Maintenance Service";
    after = [ "docker.service" ];
    requires = [ "docker.service" ];
    path = [ pkgs.coreutils ];
    serviceConfig = {
      Type = "oneshot";
      User = host.username;
      ExecStart = maintenanceScript;
      UMask = "0077";
      NoNewPrivileges = true;
      PrivateTmp = true;
      ProtectSystem = "strict";
      ProtectHome = "read-only";
      ReadWritePaths = [
        "/home/${host.username}/projects/srv"
        "/run/docker.sock"
      ];
      StandardOutput = "journal";
      StandardError = "journal";
    };
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
