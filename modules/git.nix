{ host, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gh # GitHub cli
    git-sizer # Git repo size info
    git-filter-repo # Git history ez rewrite
  ];
  programs.git = {
    enable = true;
    config = {
      user = {
        name = host.gitUsername;
        email = host.gitEmail;
      };
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };
}
