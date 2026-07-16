{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.zsh-history-substring-search
  ];
  environment.enableAllTerminfo = true;
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
  };
}
