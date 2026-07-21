{ host, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gh # GitHub cli
    git-sizer # Git repo size info
    git-filter-repo # Git history ez rewrite
  ];
  environment.shellAliases = {
    ga = "git add ."; 
    gpl = "git pull";
    gps = "git push";
    gst = "git status";
  };
  programs.git = {
    enable = true;
    config = {
      user = {
        name = host.gitUsername;
        email = host.gitEmail;
      };
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
