{ ... }:
{
  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      flags  = [
        "--cmd cd"
      ];
    };
  };
}