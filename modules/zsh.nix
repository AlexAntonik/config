{
  pkgs,
  host,
  username,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    ghostty # needed even on srv to proper ssh
    zsh-history-substring-search
  ];
  systemd.tmpfiles.rules = [
    "f /home/${username}/.zshrc 0644 ${username} users - -"
  ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    interactiveShellInit = ''
      source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
      bindkey '^[OA' history-substring-search-up
      bindkey '^[[A' history-substring-search-up
      bindkey '^[OB' history-substring-search-down
      bindkey '^[[B' history-substring-search-down
    '';

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
      fr = "nh os switch --hostname ${host}";
      fu = "nh os switch --hostname ${host} --update";
      change-host = "sh /home/${username}/config/install.sh";
      ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      lg = "lazygit";
      gst = "git status";
      man = "batman";
      ls = "eza --icons --group-directories-first -1";
      ll = "eza --icons -lh --group-directories-first -1 --no-user --long";
      la = "eza --icons -lah --group-directories-first -1";
      tree = "eza --icons --tree --group-directories-first";
      f = "fzf";

      noctalia-export = "noctalia-shell ipc call state all | jq '.settings' > /home/${username}/config/modules/noctalia/settings.json";
      ytdm = "noglob yt-dlp -t aac --embed-thumbnail -o \"~/Music/%(title)s\"";
      ytdv = "noglob yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' --embed-thumbnail -o \"~/Videos/%(title)s.%(ext)s\"";
      ytdp = "noglob yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' --embed-thumbnail -o \"~/Videos/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s\"";

      backup-list = "borg list /home/${username}/projects/srv/backup/borg-repo";
      backup-info = "borg info /home/${username}/projects/srv/backup/borg-repo";
      backup-show = "borg list /home/${username}/projects/srv/backup/borg-repo::";

      backup-restore-last = "mkdir -p /home/${username}/restored && cd /home/${username}/restored && borg extract \"/home/${username}/projects/srv/backup/borg-repo::\$(borg list /home/${username}/projects/srv/backup/borg-repo --short | tail -1)\"";
      backup-restore = "mkdir -p /home/${username}/restored && cd /home/${username}/restored && borg extract \"/home/${username}/projects/srv/backup/borg-repo::\"";

      backup-mount = "mkdir -p /home/${username}/borg_mount && borg mount /home/${username}/projects/srv/backup/borg-repo /home/${username}/borg_mount";
      backup-unmount = "fusermount -u /home/${username}/borg_mount";

      backup-stats = "borg info /home/${username}/projects/srv/backup/borg-repo --json | jq '.archives | length'";
      backup-size = "borg info /home/${username}/projects/srv/backup/borg-repo";

      backup-run = "sudo systemctl start borgbackup-job-daily-backup.service";
      backup-status = "systemctl status borgbackup-job-daily-backup.service";
      backup-logs = "journalctl -u borgbackup-job-daily-backup.service";
    };
  };
}
