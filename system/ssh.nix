{
  flake.nixosModules.ssh =
    { ... }:
    {
      services.openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "no"; # Prevent root from SSH login
          PasswordAuthentication = true; # Users can SSH using kb and password
          KbdInteractiveAuthentication = true;
        };
        ports = [ 22 ];
      };
    };
}
