{
  env = {
    # Locals
    username = "alex";
    host = "dell"; # Must be the same as dir name(as in quotes - hosts/"default"/)

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

    # Some technical stuff normally not needed to be changed
    # This file is used to store the display status (on/off)
    displayStatusFile = "$XDG_RUNTIME_DIR/display.status";
  };
}
