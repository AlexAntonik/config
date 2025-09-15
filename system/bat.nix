{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    settings = {
      pager = "less";
      paging = "never";
    };
    extraPackages = with pkgs.bat-extras; [
      batman
      batpipe
      batgrep
    ];
  };
}
