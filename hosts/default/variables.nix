{
  # Git Configuration ( For Pulling Software Repos )
  gitUsername = "AlexAntonik";
  gitEmail = "antonikavv@gmail.com";

  # Hyprland Settings
  extraMonitorSettings = "";

  # Waybar Settings
  clock24h = true;

  # Program Options
  browser = "firefox-beta"; # Set Default Browser (google-chrome-stable for google-chrome)
  terminal = "ghostty"; # Set Default System Terminal
  keyboardLayout = "us,ru";
  consoleKeyMap = "us";

  # For Nvidia Prime support
  intelID = "PCI:1:0:0";
  nvidiaID = "PCI:0:2:0";

  # Devices for some features
  touchpadID = "asue120b:00-04f3:31c0-touchpad"; # From hyprctl devices  
  keyboardLightID = "asus::kbd_backlight"; # From brightnessctl -l
  keyboardScreenOFFLightID = "asus::camera"; # From brightnessctl -l shines when screen and keyboard are off
}
