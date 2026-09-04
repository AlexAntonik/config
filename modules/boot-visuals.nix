{ config, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.tuigreet # TUI login manager
  ];
  boot.kernelParams = [ "consoleblank=300" ]; # TUI greetd display timeout
  services = {
    greetd = {
      enable = true;
      useTextGreeter = true;
      settings = {
        default_session = {
          user = "greeter";
          command = "${pkgs.tuigreet}/bin/tuigreet --time --sessions ${config.services.displayManager.sessionData.desktops}/share/xsessions:${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --remember --remember-user-session"; # start Hyprland with a TUI login manager (needed hyprland enabled systemwide!)
        };
      };
    };
  };
}
