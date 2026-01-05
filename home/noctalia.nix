{ lib, ... }:
{
  programs.noctalia-shell = {
    enable = true;
    settings = {
      bar = {
        density = "compact";
        useSeparateOpacity = true;
        outerCorners = false;
        backgroundOpacity = lib.mkForce 0.7;
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
              showIcon = false;
            }
            {
              id = "Tray";
              colorizeIcons = true;
              pinned = [
                "AmneziaVPN"
                "Telegram Desktop"
                "systray"
                "Discord"
                "steam"
              ];
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
              showNoctaliaPerformance = true;
              showPowerProfiles = true;

            }
            {
              id = "NotificationHistory";
              hideWhenZero = false;
              showUnreadBadge = true;
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
        backgroundOpacity = lib.mkForce 0.7;
      };
      osd = {
        location = "bottom";
        enabledTypes = [
          0
          1
          2
          3
          4
        ];
      };
      general = {
        avatarImage = "";
        radiusRatio = 0.2;
        lockOnSuspend = false;
      };
      sessionMenu = {
        largeButtonsStyle = false;
      };
      dock = {
        enabled = false;
      };
      ui = {
        fontFixedScale = 1.24;
        panelBackgroundOpacity = lib.mkForce 0.88;
      };
      appLauncher = {
        terminalCommand = "ghostty -e";
      };
      location = {
        monthBeforeDay = false;
        name = "Minsk, Belarus";
      };
      systemMonitor = {
        useCustomColors = true;
        criticalColor = "#630000";
        warningColor = "#6a3100";
      };
      wallpaper = {
        enabled = false;
      };
    };
  };
}
