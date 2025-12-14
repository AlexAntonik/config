{ ... }:
{
  programs.vicinae = {
    enable = true;
    systemd.enable = true;
    systemd.autoStart = true;
    settings = {
      faviconService = "twenty"; # twenty | google | none
      font.size = 11;
      popToRootOnClose = false;
      rootSearch = {
        searchFiles = true;
      };
      theme.name = "vicinae-dark";
      window = {
        csd = true;
        opacity = 0.8;
        rounding = 10;
      };
    };
  };
}
