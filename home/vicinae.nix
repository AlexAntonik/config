{ ... }:
{
  programs.vicinae = {
    enable = true;
    useLayerShell = true; 
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
    };
  };
}
