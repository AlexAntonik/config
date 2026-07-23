{ pkgs, ... }: {
  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642; #65530 too low for some games
  };
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "-W 2880" # Width
        "-H 1620" # Height
        "-r 120" # Refresh rate
        "-f" # Fullscreen
        "--expose-wayland"
        "--rt" # Realtime priority
      ];
    };
  };
}
