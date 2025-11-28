{ pkgs, env, ... }:
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
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland"; # start Hyprland with a TUI login manager
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
