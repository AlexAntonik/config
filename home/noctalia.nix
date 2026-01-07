{ lib, ... }:
{
  programs.noctalia-shell = {
    enable = true;
    settings = {
      bar = {
        density = "compact";
        useSeparateOpacity = true;
        outerCorners = false;
        backgroundOpacity = lib.mkForce 0.54;
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
              id = "Workspace";
              hideUnoccupied = false;
              labelMode = "index";
            }
            {
              id = "MediaMini";
              maxWidth = 240;
              showVisualizer = true;
              visualizerType = "wave";

            }
          ];
          center = [ ]; # needed to clear center widgets
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
              customFont = "Montserrat SemiBold";
              formatHorizontal = "HH:mm";
              useMonospacedFont = true;
              usePrimaryColor = true;
              useCustomFont = true;
            }
          ];
        };
      };
      notifications = {
        location = "bottom_right";
        backgroundOpacity = lib.mkForce 0.5;
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
      desktopWidgets = {
        enabled = true;
        gridSnap = true;
        monitorWidgets = [
          {
            name = "eDP-1";
            widgets = [
              {
                clockStyle = "binary";
                customFont = "";
                format = "HH:mm\\nd MMMM yyyy";
                id = "Clock";
                roundedCorners = true;
                scale = 3.2;
                showBackground = false;
                useCustomFont = false;
                usePrimaryColor = true;
                x = 1040;
                y = 440;
              }
            ];
          }
        ];

      };
      general = {
        avatarImage = "";
        radiusRatio = 0.2;
        lockOnSuspend = false;
      };
      sessionMenu = {
        largeButtonsStyle = true;
        largeButtonsLayout = "grid";
      };
      dock = {
        enabled = false;
      };
      ui = {
        fontFixedScale = 1.24;
        panelBackgroundOpacity = lib.mkForce 0.76;
      };
      calendar = {
        cards = [
          {
            enabled = true;
            id = "calendar-header-card";
          }
          {
            enabled = true;
            id = "calendar-month-card";
          }
          {
            enabled = true;
            id = "timer-card";
          }
          {
            enabled = false;
            id = "weather-card";
          }
        ];
      };

      appLauncher = {
        terminalCommand = "ghostty -e";
      };
      location = {
        monthBeforeDay = false;
        analogClockInCalendar = true;
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
