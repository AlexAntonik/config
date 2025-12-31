{ lib, ... }:
{
  programs.noctalia-shell = {
    enable = true;
    settings = {
      bar = {
        density = "compact";
        useSeparateOpacity = true;
        outerCorners = false;
        backgroundOpacity = lib.mkForce 0.65;
        position = "bottom";
        showCapsule = false;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              colorizeSystemIcon = "primary";
              enableColorization = true;
              useDistroLogo = true;
            }
            {
              id = "SystemMonitor";
            }
            {
              id = "MediaMini";
              maxWidth = 240;
              showVisualizer = true;
              visualizerType = "wave";

            }
          ];
          center = [
            {
              id = "Workspace";
              hideUnoccupied = false;
              labelMode = "none";
            }
          ];
          right = [
            {
              id = "KeyboardLayout";
              displayMode = "forceOpen";
            }
            {
              id = "Tray";
              colorizeIcons = true;
            }
            {
              id = "WiFi";
            }
            {
              id = "Bluetooth";
            }
            {
              id = "Battery";
              alwaysShowPercentage = false;
              warningThreshold = 30;
            }
            {
              id = "Clock";
              formatHorizontal = "HH:mm ddd, MMM dd";
              formatVertical = "HH mm - dd MM";
              useMonospacedFont = true;
              usePrimaryColor = true;
              useCustomFont = true;
              customFont = "Liberation Sans";
            }
          ];
        };
      };
      notifications = {
        location = "bottom_right";
        backgroundOpacity = lib.mkForce 0.5;
      };
      osd = {
        location = "bottom_center";
      };
      general = {
        avatarImage = "";
        radiusRatio = 0.2;
        lockOnSuspend = false;
      };
      ui = {
        fontFixedScale = 1.24;
        panelBackgroundOpacity = lib.mkForce 0.8;
      };
      appLauncher = {
        terminalCommand = "ghostty -e";
      };
      location = {
        monthBeforeDay = false;
        name = "Minsk, Belarus";
      };
      wallpaper = {
        enabled = false;
      };
    };
  };
}
