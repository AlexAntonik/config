{ host, pkgs, ... }:
let
  maintenanceScript = pkgs.writeShellScript "docker-compose-maintenance" ''
    set -euo pipefail

    compose_dir="/home/${host.username}/projects/srv"
    backup_dir="$compose_dir/backup"
    staging_dir="$compose_dir/.backup-staging"
    docker="${pkgs.docker}/bin/docker"

    if [ ! -d "$compose_dir" ]; then
      echo "Error: $compose_dir not found" >&2
      exit 1
    fi
    mkdir -p "$backup_dir" "$staging_dir"
    cd "$compose_dir"

    timestamp="$(date +%Y%m%d_%H%M%S)"
    staged_file="$staging_dir/database-dump_$timestamp.sql"
    final_file="$backup_dir/database-dump_$timestamp.sql"

    cleanup() {
      rm -f "$staged_file"
    }
    trap cleanup EXIT
    trap 'exit 130' INT
    trap 'exit 143' TERM

    echo "Dumping database at $(date)"
    "$docker" compose exec -T db pg_dump -U postgres --clean --if-exists >"$staged_file"
    mv "$staged_file" "$final_file"

    # keep the 5 newest dumps; zero-padded timestamps sort lexicographically
    shopt -s nullglob
    dumps=("$backup_dir"/database-dump_*.sql)
    if [ "''${#dumps[@]}" -gt 5 ]; then
      rm -f "''${dumps[@]:0:''${#dumps[@]}-5}"
    fi

    echo "Database maintenance completed at $(date)"
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
      TimeoutStartSec = "30m";
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
      RandomizedDelaySec = "30m";
    };
  };
}
