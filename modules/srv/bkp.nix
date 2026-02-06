{ env, pkgs, ... }:
{
  services.borgbackup.jobs = {
    "daily-backup" = {
      paths = [
        "/home/${env.username}/projects/srv/volumes"
      ];

      repo = "/home/${env.username}/projects/srv/backup/borg-repo";

      startAt = "04:00";

      compression = "zstd,3";
      encryption.mode = "none";

      exclude = [ ];

      prune.keep = {
        daily = 7;
      };

      extraCreateArgs = "--stats --show-rc";

      extraPruneArgs = "--stats --show-rc";

      environment.BORG_UNKNOWN_UNENCRYPTED_REPO_ACCESS_IS_OK = "yes";

      preHook = ''
        echo "Starting backup at $(date)"
      '';

      postHook = ''
        echo "Backup completed at $(date)"
        chown -R ${env.username}:users /home/${env.username}/projects/srv/backup/borg-repo
      '';
    };
  };

  systemd.tmpfiles.rules = [
    "d /home/${env.username}/projects/srv/backup 0755 ${env.username} users -"
    "d /home/${env.username}/projects/srv/backup/borg-repo 0755 ${env.username} users -"
  ];
  systemd.services.borgbackup-init = {
    description = "Initialize Borg Repository";
    wantedBy = [ "multi-user.target" ];
    before = [ "borgbackup-job-daily-backup.service" ];

    serviceConfig = {
      Type = "oneshot";
      User = env.username;
      Group = "users";
      RemainAfterExit = true;
    };

    script = ''
      REPO_PATH="/home/${env.username}/projects/srv/backup/borg-repo"

      if ! ${pkgs.borgbackup}/bin/borg info "$REPO_PATH" &>/dev/null; then
        echo "Initializing Borg repository at $REPO_PATH"
        ${pkgs.borgbackup}/bin/borg init --encryption=none "$REPO_PATH"
        echo "Borg repository initialized successfully"
      else
        echo "Borg repository already exists at $REPO_PATH"
      fi
    '';
  };
  systemd.services = {
    "borgbackup-job-daily-backup" = {
      serviceConfig = {
        StandardOutput = "journal";
        StandardError = "journal";
      };
    };
  };
}
