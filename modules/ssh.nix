{
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no"; # Prevent root from SSH login
      PasswordAuthentication = false;
    };
    ports = [ 22 ];
  };
}
