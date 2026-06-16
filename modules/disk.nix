{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    smartmontools
    qdiskinfo 
  ];
  services.smartd = {
    enable = true;
    autodetect = true;
  };
}
