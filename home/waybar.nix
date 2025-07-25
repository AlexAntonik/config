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
        start_hidden = true;
        layer = "bottom";
        position = "bottom";
        modules-center = [
        ];
        modules-left = [
          "idle_inhibitor"
          "pulseaudio"
          "group/cpu"
          "group/memory"
          "group/battery"
          "group/network"
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
        "memory#icon" = {
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
          tooltip-format = "RAM: {used:0.1f}GB/{total:0.1f}GB\nSwap: {swapUsed:0.1f}GB/{swapTotal:0.1f}GB";
          on-click = "sleep 0.1 && hyprctl dispatch exec '[float] ghostty -e btop'";
        };
        "memory#usage" = {
          interval = 5;
          format = "<span color='{icon}'> {percentage}%</span>";
          format-icons = [
            "#f8f8f2"
            "#f8f8f2"
            "#f8f8f2"
            "#f8f8f2"
            "#f8f8f2"
            "#f8f8f2"
            "#ffffa5"
            "#ff9977"
            "#dd532e"
          ];
          tooltip = true;
          tooltip-format = "RAM: {used:0.1f}GB/{total:0.1f}GB\nSwap: {swapUsed:0.1f}GB/{swapTotal:0.1f}GB";
          on-click = "sleep 0.1 && hyprctl dispatch exec '[float] ghostty -e btop'";
        };
        "group/memory" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            transition-left-to-right = true;
          };
          modules = [
            "memory#icon"
            "memory#usage"
          ];
        };
        "cpu#icon" = {
          interval = 4;
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
        "cpu#usage" = {
          interval = 4;
          format = "<span color='{icon}'> {usage}%</span>";
          format-icons = [
            "#f8f8f2"
            "#ffffa5"
            "#ff9977"
            "#dd532e"
          ];
          tooltip = true;
          on-click = "sleep 0.1 && hyprctl dispatch exec '[float] ghostty -e btop'";
        };
        "group/cpu" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            transition-left-to-right = true;
          };
          modules = [
            "cpu#icon"
            "cpu#usage"
          ];
        };
        "disk" = {
          format = "";
          tooltip = true;
        };
        "network#icon" = {
          interval = 3600;
          format = "{icon}";
          format-icons = [
            "<span color='#f8f8f2'>󰇚</span>"
          ];
          format-disconnected = "<span color='#f8f8f2'>󱂰</span>";
          tooltip = false;
        };
        "network#speed" = {
          interval = 4;
          format = "<span color='#f8f8f2'> {bandwidthDownBytes} 󰕒 {bandwidthUpBytes}</span>";
          format-disconnected = "";
          tooltip = false;
        };
        "group/network" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            transition-left-to-right = true;
          };
          modules = [
            "network#icon"
            "network#speed"
          ];
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
        "idle_inhibitor" = {
          format = "{icon}";
          on-click-right = "sleep 0.1 && wlogout";
          format-icons = {
            activated = "<span color='#ff9977'> 󰈈</span>";
            deactivated = "";
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
        "battery#icon" = {
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
          on-click = "sleep 0.1 && hyprctl dispatch exec '[float] ghostty -e btop'";
          tooltip = true;
        };
        "battery#left" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "<span color='{icon}'> {capacity}%</span>";
          format-icons = [
            "#dd532e"
            "#ff9977"
            "#ffffa5"
            "#ffffa5"
            "#f8f8f2"
            "#f8f8f2"
            "#f8f8f2"
            "#f8f8f2"
            "#f8f8f2"
            "#f8f8f2"
            "#f8f8f2"
          ];
          on-click = "sleep 0.1 && hyprctl dispatch exec '[float] ghostty -e btop'";
          tooltip = true;
        };
        "group/battery" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            transition-left-to-right = true;
          };
          modules = [
            "battery#icon"
            "battery#left"
          ];
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
          margin-top: 1px;
          margin-bottom: 1px;
          background: transparent;
        }
        window#waybar {
          background: rgba(0, 0, 0, 0.4); /* Черный с прозрачностью 30% */
          border-radius: 0;
          border-top: 1px solid rgba(0, 0, 0, 0.44); /* Затемненная полоска сверху */
        }
        menu {
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
          padding: 0px 22px;
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

        #idle_inhibitor, #pulseaudio, #cpu.icon, #memory.icon, #network.icon, #battery.icon {
          padding-right: 0px;
          padding-left: 0px;
          margin-left: 12px;
          margin-right: 0px;
        }

        #idle_inhibitor {
          padding-left: 4px;
        }

        #cpu.usage, #memory.usage, #network.speed, #battery.left {
          padding-right: 0px;
          padding-left: 0px;
          margin-left: 0px;
          margin-right: 0px;
        }

        #language {
          font-weight: bold;
          margin: 0px;
          padding: 0px 10px;
          background: transparent;
          color: #CCCCCC;
        }
        #tray{
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
