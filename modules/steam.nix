{ ... }:
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
        "-W 2880"
        "-H 1620"
        "-r 120"
        "-f"
        "--rt"
      ];
    };
  };
}
