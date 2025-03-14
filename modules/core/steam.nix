{pkgs, ...}: {
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = false;
      gamescopeSession.enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
    };

    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--rt"
        "--expose-wayland"
        "--immediate-flips"
        "--adaptive-sync"
        "--prefer-output"
        "--output-width 2880"
        "--output-height 1620"
        "-w 2880"
        "-h 1620"
        "-W 2880"
        "-H 1620"
        "-r 120"  
      ];
    };
  };
}
