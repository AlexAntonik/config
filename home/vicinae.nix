{ ... }:
{
  programs.vicinae = {
    enable = true;
    systemd.enable = true;
    systemd.autoStart = true;
    settings = {
      faviconService = "twenty"; # twenty | google | none
      font.size = 11;
      popToRootOnClose = true;
      closeOnFocusLoss = true;
      rootSearch = {
        searchFiles = true;
      };
      theme.name = "catppuccin-macchiato";
      window = {
        csd = true;
        opacity = 0.8;
        rounding = 10;
      };
    };
  };
}
