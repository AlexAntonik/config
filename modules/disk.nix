{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.smartmontools
    pkgs.qdiskinfo 
  ];
  services.smartd = {
    enable = true;
    autodetect = true;
  };
}
