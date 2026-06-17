{ pkgs, host, ... }:
{
  environment.systemPackages = with pkgs; [
    ghostty # needed even on srv to proper ssh
    zsh-history-substring-search
  ];
  systemd.tmpfiles.rules = [
    "f /home/${host.username}/.zshrc 0644 ${host.username} users - -"
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
        "line"
      ];
    };

    histSize = 20000;

    shellAliases = {
      sv = "sudo nvim";
      v = "nvim";
      c = "clear";
      fr = "nh os switch --hostname ${host.hostname} --diff=always";
      fu = "nh os switch --hostname ${host.hostname} --update --diff=always";
      change-host = "sh ${host.flakePath}/install.sh";
      ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      lg = "lazygit";
      gpl = "git pull --rebase";
      gps = "git push";
      gst = "git status";
      man = "batman";
      ls = "eza --icons --group-directories-first -1";
      ll = "eza --icons -lh --group-directories-first -1 --no-user --long";
      la = "eza --icons -lah --group-directories-first -1";
      tree = "eza --icons --tree --group-directories-first";
      f = "fzf";

      ytdm = "noglob yt-dlp -t aac --embed-thumbnail -o \"~/Music/%(title)s\"";
      ytdv = "noglob yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' --embed-thumbnail -o \"~/Videos/%(title)s.%(ext)s\"";
      ytdp = "noglob yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' --embed-thumbnail -o \"~/Videos/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s\"";
    };
  };
}
