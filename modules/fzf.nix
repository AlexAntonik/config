{
  environment.shellAliases = {
    f = "fzf";
  };
  home.programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
