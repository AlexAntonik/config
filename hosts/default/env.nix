{
  # Flake locals 
  username = "default";

  # Git Configuration ( For Pulling Software Repos )
  gitUsername = "AlexAntonik";
  gitEmail = "antonikavv@gmail.com";

  # Hyprland Settings
  extraMonitorSettings = "";

  # Waybar Settings
  clock24h = true;

  # Program Options
  browser = "firefox"; # Set Default Browser (google-chrome-stable for google-chrome)
  terminal = "ghostty"; # Set Default System Terminal
  keyboardLayout = "us,ru";

  # Devices for some features
  touchpadID = "asue120b:00-04f3:31c0-touchpad"; # From hyprctl devices  
  keyboardLightID = "asus::kbd_backlight"; # From brightnessctl -l
  keyboardScreenOFFLightID = "asus::camera"; # From brightnessctl -l shines when screen and keyboard are off
  languageLightID = "platform::micmute"; # Same used to indicate not en lang

  # Time and Locale Settings
  timeZone = "Europe/Minsk";
  defaultLocale = "en_US.UTF-8";
  extraLocaleSettings = "en_US.UTF-8";

  # Some technical stuff normally not needed to be changed
  # This file is used to store the display status (on/off)  
  displayStatusFile = "$XDG_RUNTIME_DIR/display.status";
}
