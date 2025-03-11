{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    audacity
    discord
    vesktop
    nodejs
    obs-studio
  ];
}
