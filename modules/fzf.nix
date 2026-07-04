{pkgs, ...}:{
  environment.shellAliases = {
    f = "fzf";
  };
  environment.systemPackages = [
    pkgs.fzf
  ];
  programs.fzf = {
    keybindings = true;
    fuzzyCompletion = true;
  };
}
