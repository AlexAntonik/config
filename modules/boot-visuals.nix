{ config,pkgs, env, ... }:
{
  environment.systemPackages = with pkgs; [
    tuigreet # The login manager (sometimes referred to as display manager)
  ];
  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          user = env.username;
          command = "${pkgs.tuigreet}/bin/tuigreet --time --sessions ${config.services.displayManager.sessionData.desktops}/share/xsessions:${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --remember --remember-user-session"; # start Hyprland with a TUI login manager (needed hyprland enabled systemwide!) 
        };
      };
    };
  };
  boot = {
        # Uncomment for fancy startup loading animation
    # plymouth.enable = true;
    # plymouth.themePackages = [
    # pkgs.adi1090x-plymouth-themes
    # ];
    # plymouth.theme = "rings";
  };
}
