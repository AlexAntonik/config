{ profile, ... }:
{
  programs.bash = {
    enable = false;
    enableCompletion = true;
    initExtra = ''
      fastfetch
    '';
    shellAliases = {
      sv = "sudo nvim";
      fr = "nh os switch --hostname ${profile}";
      fu = "nh os switch --hostname ${profile} --update";
      su = "sh <(curl -L https://raw.githubusercontent.com/AlexAntonik/config/refs/heads/master/install.sh)";
      ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      v = "nvim";
      cat = "bat";
      ls = "eza --icons";
      ll = "eza -lh --icons --grid --group-directories-first";
      la = "eza -lah --icons --grid --group-directories-first";
      f ="nvim $(fzf --preview=\"bat --color=always {}\")";
      ".." = "cd ..";
    };
  };
}
