{ pkgs, username, ... }:
{
  environment.systemPackages = with pkgs; [
    greetd.tuigreet # The login manager (sometimes referred to as display manager)
  ];
  services = {
    greetd = {
      enable = true;
      vt = 3;
      settings = {
        default_session = {
          user = username;
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland"; # start Hyprland with a TUI login manager
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
