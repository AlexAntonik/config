{ ... }:
{
  programs.noctalia-shell = {
    enable = true;
    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        timer = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        screen-recorder = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        tailscale = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
      version = 1;
    };
    settings = {
      bar = {
        density = "compact";
        useSeparateOpacity = true;
        outerCorners = false;
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
              maxWidth = 360;
              compactMode = true;
              showVisualizer = false;
              showAlbumArt = false;
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
              id = "plugin:tailscale";
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
                hideMode = "hidden";
                id = "MediaPlayer";
                roundedCorners = false;
                scale = 3.8;
                showAlbumArt = false;
                showBackground = false;
                showButtons = false;
                showVisualizer = true;
                visualizerType = "mirrored";
                x = -44;
                y = -165;
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
            enabled = false;
            id = "weather-card";
          }
        ];
      };

      appLauncher = {
        terminalCommand = "ghostty -e";
      };
      controlCenter = {
        shortcuts = {
          left = [
            {
              id = "Network";
            }
            {
              id = "Bluetooth";
            }
            {
              defaultSettings = {
                compactMode = false;
                defaultDuration = 0;
              };
              id = "plugin:timer";
            }
            {
              defaultSettings = {
                audioCodec = "opus";
                audioSource = "default_output";
                colorRange = "limited";
                copyToClipboard = false;
                directory = "";
                filenamePattern = "recording_yyyyMMdd_HHmmss";
                frameRate = "60";
                quality = "very_high";
                showCursor = true;
                videoCodec = "h264";
                videoSource = "portal";
              };
              id = "plugin:screen-recorder";
            }
            {
              id = "WallpaperSelector";
            }

          ];
          right = [
            {
              id = "Notifications";
            }
            {
              id = "PowerProfile";
            }
            {
              id = "KeepAwake";
            }
            {
              id = "NightLight";
            }
          ];
        };
      };
      location = {
        monthBeforeDay = false;
        analogClockInCalendar = true;
        name = "Minsk, Belarus";
      };
      systemMonitor = {
        useCustomColors = true;
        warningColor = "#d08a5e";
      };
      wallpaper = {
        enabled = true;
        hideWallpaperFilenames = true;
      };
    };
  };
}
