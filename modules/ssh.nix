{
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no"; # Prevent root from SSH login
      PasswordAuthentication = false;
      MaxAuthTries = 3;
      LoginGraceTime = 20;
      # keep NAT state alive / reap dead clients
      ClientAliveInterval = 30;
      ClientAliveCountMax = 3;
    };
    ports = [ 22 ];
  };
}
