{
  env = {
    # Flake locals
    username = "user";
    host = "swprod"; # Must be the same as dir name(as in quotes - hosts/"default"/)

    # Git Configuration ( For Pulling Software Repos )
    gitUsername = "AlexAntonik";
    gitEmail = "antonikavv@gmail.com";

    # Hyprland Settings
    extraMonitorSettings = "";
    keyboardLayout = "us,ru";

    # Devices for some features
    touchpadID = "asue120b:00-04f3:31c0-touchpad"; # From hyprctl devices
    keyboardLightID = "asus::kbd_backlight"; # From brightnessctl -l
    keyboardScreenOFFLightID = "asus::camera"; # From brightnessctl -l shines when screen and keyboard are off

    # Time and Locale Settings
    timeZone = "Europe/Minsk";
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = "en_US.UTF-8";

    # This value determines the Home Manager/NixOs release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager/NixOs release
    # introduces backwards incompatible changes.
    #
    # You should not change this , even if you update Home Manager/NixOs. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "23.11";
  };
}
