{pkgs,...}:{
  services.wlsunset = {
    enable = true;
    sunset = "20:00";
    sunrise = "07:00";
    package = pkgs.wlsunset;
  };
}