{
  pkgs,
  env,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    ghostty # needed even on srv to proper ssh
  ];
  systemd.tmpfiles.rules = [
    "f /home/${env.username}/.zshrc 0644 ${env.username} users - -"
  ];
  programs.zsh = {
    enable = true;
    autosuggestions = {
      enable = true;
      strategy = [
        "history"
        "completion"
      ];
    };
    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "main"
        "brackets"
        "pattern"
        "regexp"
        # "root" #on root inveting colors with this
        "line"
      ];
    };

    histSize = 10000;

    shellAliases = {
      sv = "sudo nvim";
      v = "nvim";
      c = "clear";
      fr = "nh os switch --hostname ${env.host}";
      fu = "nh os switch --hostname ${env.host} --update";
      change-host = "sh /home/${env.username}/config/install.sh";
      ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      lg = "lazygit";
      man = "batman";
      ls = "eza --icons --group-directories-first -1";
      ll = "eza --icons -lh --group-directories-first -1 --no-user --long";
      la = "eza --icons -lah --group-directories-first -1";
      tree = "eza --icons --tree --group-directories-first";
      f = "fzf";
      ytdm = "noglob yt-dlp -t aac --embed-thumbnail -o \"~/Music/%(title)s\"";
      ytdv = "noglob yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' --embed-thumbnail -o \"~/Videos/%(title)s.%(ext)s\"";
      ytdp = "noglob yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' --embed-thumbnail -o \"~/Videos/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s\"";


      backup-list = "borg list /home/${env.username}/projects/srv/backup/borg-repo";
      backup-info = "borg info /home/${env.username}/projects/srv/backup/borg-repo";
      backup-show = "borg list /home/${env.username}/projects/srv/backup/borg-repo::";

      backup-restore-last = "mkdir -p /home/${env.username}/restored && cd /home/${env.username}/restored && borg extract \"/home/${env.username}/projects/srv/backup/borg-repo::\$(borg list /home/${env.username}/projects/srv/backup/borg-repo --short | tail -1)\"";
      backup-restore = "mkdir -p /home/${env.username}/restored && cd /home/${env.username}/restored && borg extract \"/home/${env.username}/projects/srv/backup/borg-repo::\"";
      
      backup-mount = "mkdir -p /home/${env.username}/borg_mount && borg mount /home/${env.username}/projects/srv/backup/borg-repo /home/${env.username}/borg_mount";
      backup-unmount = "fusermount -u /home/${env.username}/borg_mount";

      backup-stats = "borg info /home/${env.username}/projects/srv/backup/borg-repo --json | jq '.archives | length'";
      backup-size = "borg info /home/${env.username}/projects/srv/backup/borg-repo";

      backup-run = "sudo systemctl start borgbackup-job-daily-backup.service";
      backup-status = "systemctl status borgbackup-job-daily-backup.service";
      backup-logs = "journalctl -u borgbackup-job-daily-backup.service";
    };
  };
}
