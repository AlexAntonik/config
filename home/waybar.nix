{
  pkgs,
  lib,
  host,
  config,
  ...
}:
let
  betterTransition = "all 0.3s cubic-bezier(.55,-0.68,.48,1.682)";
  inherit (import ../hosts/${host}/variables.nix) clock24h;
in
with lib;
{
  # Configure & Theme Waybar
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [
      {
        layer = "bottom";
        position = "bottom";
        modules-center = [
        ];
        modules-left = [
          "custom/startmenu"
          "custom/exit"
          "idle_inhibitor"
          "pulseaudio"
          "cpu"
          "memory"
          "battery"
          "hyprland/workspaces"
        ];
        modules-right = [
          "hyprland/language"
          "tray"
          "custom/notification"
          "clock"
        ];

        "hyprland/language" = {
          format-en = "En";
          format-ru = "Ru";
          min-length = 3;
          tooltip = false;
          on-click = "sleep 0.1 && hyprctl switchxkblayout at-translated-set-2-keyboard next";
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "F1";
            "7" = "F2";
            "8" = "F3";
            "9" = "F4";
            "10" = "F5";
            # "urgent" = "";
            # "active" = "";
            # "default" = "";
          };
        };
        "clock" = {
          format = if clock24h == true then ''{:L%H:%M}'' else ''{:L%I:%M %p}'';
          tooltip = true;
          tooltip-format = "<big>{:%A, %d.%B %Y }</big>\n<tt><small>{calendar}</small></tt>";
          timezone = "Etc/GMT-3";
        };
        "memory" = {
          interval = 5;
          format = "{icon}";
          format-icons = [
            "<span color='#f8f8f2'></span>"
            "<span color='#f8f8f2'></span>"
            "<span color='#f8f8f2'></span>"
            "<span color='#f8f8f2'></span>"
            "<span color='#f8f8f2'></span>"
            "<span color='#f8f8f2'></span>"
            "<span color='#ffffa5'></span>"
            "<span color='#ff9977'></span>"
            "<span color='#dd532e'></span>"
          ];
          tooltip = true;
          on-click = "sleep 0.1 && hyprctl dispatch exec '[float] ghostty -e btop'";
        };
        "cpu" = {
          interval = 5;
          format = "{icon}";
          format-icons = [
            "<span color='#f8f8f2'></span>"
            "<span color='#ffffa5'></span>"
            "<span color='#ff9977'></span>"
            "<span color='#dd532e'></span>"
          ];
          tooltip = true;
          on-click = "sleep 0.1 && hyprctl dispatch exec '[float] ghostty -e btop'";
        };
        "disk" = {
          format = "";
          tooltip = true;
        };
        "network" = {
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          format-ethernet = " {bandwidthDownOctets}";
          format-wifi = "{icon} {signalStrength}%";
          format-disconnected = "󰤮";
          tooltip = false;
        };
        "tray" = {
          spacing = 12;
        };
        "pulseaudio" = {
          format = "{icon}{format_source}";
          format-bluetooth = "{icon}{format_source}";
          format-bluetooth-muted = "󰖁 {format_source}";
          format-muted = "󰖁{format_source}";
          format-source = "";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              "󰕾"
            ];
          };
          on-click = "sleep 0.1 && pavucontrol";
        };
        "custom/exit" = {
          tooltip = false;
          format = "";
          on-click = "sleep 0.1 && wlogout";
        };
        "custom/startmenu" = {
          tooltip = false;
          format = "";
          # exec = "rofi -show drun";
          # on-click = "sleep 0.1 && rofi-launcher";
          on-click = "sleep 0.1 && nwg-drawer";
        };
        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "<span color='#ff9977'></span>";
            deactivated = "";
          };
          tooltip = "true";
        };
        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "sleep 0.1 && task-waybar";
          escape = true;
        };
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}";
          format-charging = "󰂄";
          format-plugged = "󱘖";
          format-icons = [
            "<span color='#dd532e'>󰁺</span>"
            "<span color='#ff9977'>󰁻</span>"
            "<span color='#ffffa5'>󰁼</span>"
            "<span color='#ffffa5'>󰁽</span>"
            "<span color='#f8f8f2'>󰁾</span>"
            "<span color='#f8f8f2'>󰁿</span>"
            "<span color='#f8f8f2'>󰂀</span>"
            "<span color='#f8f8f2'>󰂀</span>"
            "<span color='#f8f8f2'>󰂁</span>"
            "<span color='#f8f8f2'>󰂂</span>"
            "<span color='#f8f8f2'>󰁹</span>"
          ];
          on-click = "";
          tooltip = true;
        };
      }
    ];
    style = concatStrings [
      ''
        * {
          font-family: JetBrainsMono Nerd Font Mono;
          font-size: 14px;
          border-radius: 0;
          border: none;
          min-height: 0;
          margin: 1px;
          background: transparent;
        }
        #network-menu {
          background: #${config.lib.stylix.colors.base02};
          color: #${config.lib.stylix.colors.base05};
        }

        #pulseaudio-menu {
          background: #${config.lib.stylix.colors.base02};
          color: #${config.lib.stylix.colors.base05};
        }

        menu, tooltip, popover, .popup {
          background: #${config.lib.stylix.colors.base02};
          color: #${config.lib.stylix.colors.base05};
        }

        menu > *:hover {
          background: #${config.lib.stylix.colors.base03};
          color: #${config.lib.stylix.colors.base05};
        }
        #workspaces {
          color: #${config.lib.stylix.colors.base00};
          background: transparent;
          margin: 0px;
          padding: 0px 10px;
        }
        #workspaces button {
          font-weight: bold;
          padding: 0px 0px;
          margin: 0px;
          color: #${config.lib.stylix.colors.base0D};
          background: transparent;
          opacity: 0.5;
          transition: ${betterTransition};
        }
        #workspaces button.active {
          font-weight: bold;
          padding: 0px 0px;
          margin: 0px;
          color: #CCCCCC;
          background: transparent;
          transition: ${betterTransition};
          opacity: 0.5;
          min-width: 24px;
        }
        #workspaces button:hover {
          font-weight: bold;
          color: #${config.lib.stylix.colors.base00};
          background: #${config.lib.stylix.colors.base0C};
          opacity: 0.8;
          transition: ${betterTransition};
        }
        tooltip {
          background: #${config.lib.stylix.colors.base00};
          border: 1px solid #${config.lib.stylix.colors.base08};
        }
        tooltip label {
          color: #${config.lib.stylix.colors.base0D};
        }

        #cpu, #pulseaudio, #memory, #battery,
        #custom-startmenu, #idle_inhibitor, #custom-exit {
          font-weight: bold;
          margin: 0px;
          padding: 0px 6px;
          background: transparent;
          color: #CCCCCC;
        }

        #custom-startmenu {
          padding-left: 14px;
        }

        #battery {
          padding-right: 8px;
        }
        #language {
          font-weight: bold;
          margin: 0px;
          padding: 0px 10px;
          background: transparent;
          color: #CCCCCC;
        }
        #network, #tray{
          font-weight: bold;
          background: transparent;
          color: #CCCCCC;
          margin: 0px;
          padding: 0px 6px 0px 16px;
        }
        #custom-notification{
          font-weight: bold;
          background: transparent;
          color: #CCCCCC;
          margin: 0px;
          padding: 0px 16px 0px 6px;
        }
        #clock {
          font-weight: bold;
          color: #CCCCCC;
          background: transparent;
          margin: 0px;
          padding: 0px 12px 0px 16px;
        }
      ''
    ];
  };
}
