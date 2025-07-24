{ username, pkgs, ... }:
let
  aliases = {
    # Просмотр бэкапов
    backup-list = "borg list /home/${username}/projects/srv/backup/borg-repo";
    backup-info = "borg info /home/${username}/projects/srv/backup/borg-repo";
    backup-show = "borg list /home/${username}/projects/srv/backup/borg-repo::";

    # Восстановление
    backup-restore-last = "mkdir -p /home/${username}/restored && borg extract /home/${username}/projects/srv/backup/borg-repo::\$(borg list /home/${username}/projects/srv/backup/borg-repo --short | tail -1) /home/${username}/restored/";
    backup-restore = "mkdir -p /home/${username}/restored && borg extract /home/${username}/projects/srv/backup/borg-repo:: --destination /home/${username}/restored";

    # Монтирование для просмотра
    backup-mount = "mkdir -p /home/${username}/borg_mount && borg mount /home/${username}/projects/srv/backup/borg-repo /home/${username}/borg_mount";
    backup-unmount = "fusermount -u /home/${username}/borg_mount";

    # Статистика
    backup-stats = "borg info /home/${username}/projects/srv/backup/borg-repo --json | jq '.archives | length'";
    backup-size = "borg info /home/${username}/projects/srv/backup/borg-repo";

    # Ручной запуск бэкапа
    backup-run = "sudo systemctl start borgbackup-job-daily-backup.service";
    backup-status = "systemctl status borgbackup-job-daily-backup.service";
    backup-logs = "journalctl -u borgbackup-job-daily-backup.service";
  };
in
{
  services.borgbackup.jobs = {
    "daily-backup" = {
      paths = [
        "/home/${username}/projects/srv/volumes"
      ];

      repo = "/home/${username}/projects/srv/backup/borg-repo";

      startAt = "02:00";

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
        chown -R ${username}:users /home/${username}/projects/srv/backup/borg-repo
      '';
    };
  };

  systemd.tmpfiles.rules = [
    "d /home/${username}/projects/srv/backup 0755 ${username} users -"
    "d /home/${username}/projects/srv/backup/borg-repo 0755 ${username} users -"
  ];
  systemd.services.borgbackup-init = {
    description = "Initialize Borg Repository";
    wantedBy = [ "multi-user.target" ];
    before = [ "borgbackup-job-daily-backup.service" ];

    serviceConfig = {
      Type = "oneshot";
      User = username;
      Group = "users";
      RemainAfterExit = true;
    };

    script = ''
      REPO_PATH="/home/${username}/projects/srv/backup/borg-repo"

      # Проверяем, инициализирован ли уже репозиторий
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
    # journalctl -u borgbackup-job-daily-backup
    "borgbackup-job-daily-backup" = {
      serviceConfig = {
        StandardOutput = "journal";
        StandardError = "journal";
      };
    };
  };

 
#   programs.zsh.shellAliases = aliases;
  environment.shellAliases = aliases;
}
