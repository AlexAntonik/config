{
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no"; # Prevent root from SSH login
      PasswordAuthentication = false;
      MaxAuthTries = 3;
      LoginGraceTime = 20;
    };
    ports = [ 22 ];
  };
}
