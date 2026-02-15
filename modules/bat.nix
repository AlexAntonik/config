{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    settings = {
      pager = "less";
      paging = "never";
    };
    extraPackages = with pkgs.bat-extras; [
      batman      # man pager using bat
      batpipe     # Pipe to git/less with bat
      batgrep     # grep alternative with bat
    ];
  };
}
