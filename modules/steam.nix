{
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
    };

    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "-W 2880"  # Width
        "-H 1620"  # Height
        "-r 120"   # Refresh rate
        "-f"       # Fullscreen
        "--rt"     # Realtime priority
      ];
    };
  };
}
