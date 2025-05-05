{
  pkgs,
  config,
  ...
}:
{
  programs = {
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      extraConfig = {
        modi = "drun,filebrowser,run";
        show-icons = true;
        icon-theme = "Papirus";
        font = "JetBrainsMono Nerd Font Mono 12";
        drun-display-format = "{icon} {name}";
        display-drun = " Apps";
        display-run = " Run";
        display-filebrowser = " File";
      };
      theme =
        let
          inherit (config.lib.formats.rasi) mkLiteral;
        in
        {
          "*" = {
            bg = mkLiteral "rgba(50, 50, 50, 0.85)";
            bg-alt = mkLiteral "rgba(70, 70, 70, 0.85)";
            foreground = mkLiteral "rgba(204, 204, 204, 1)";
            selected = mkLiteral "rgb(124, 124, 124)";
            active = mkLiteral "rgba(187, 187, 187, 1)";
            text-selected = mkLiteral "rgba(0, 0, 0, 1)";
            text-color = mkLiteral "rgba(221, 221, 221, 1)";
            border-color = mkLiteral "rgba(136, 136, 136, 1)";
            urgent = mkLiteral "rgba(255, 85, 85, 1)";
          };
          "window" = {
            transparency = "real";
            width = mkLiteral "500px";
            location = mkLiteral "center";
            anchor = mkLiteral "center";
            fullscreen = false;
            x-offset = mkLiteral "0px";
            y-offset = mkLiteral "0px";
            cursor = "default";
            enabled = true;
            border-radius = mkLiteral "15px";
            border = mkLiteral "2px";
            border-color = mkLiteral "@border-color";
            background-color = mkLiteral "@bg";
          };
          "mainbox" = {
            enabled = true;
            spacing = mkLiteral "0px";
            orientation = mkLiteral "vertical";  
            children = map mkLiteral [
              "inputbar"     
              "listbox"      
              "mode-switcher"  
            ];
            background-color = mkLiteral "transparent";
          };

          "listbox" = {
            spacing = mkLiteral "10px";
            padding = mkLiteral "10px";
            background-color = mkLiteral "transparent";
            orientation = mkLiteral "vertical";
            children = map mkLiteral [
              "message"
              "listview"
            ];
          };
          "inputbar" = {
            enabled = true;
            spacing = mkLiteral "10px";
            padding = mkLiteral "15px";
            margin = mkLiteral "10px";
            border-radius = mkLiteral "10px";
            background-color = mkLiteral "@bg-alt";
            text-color = mkLiteral "@foreground";
            children = map mkLiteral [
              "textbox-prompt-colon"
              "entry"
            ];
          };
          "textbox-prompt-colon" = {
            enabled = true;
            expand = false;
            str = "";
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "inherit";
          };
          "entry" = {
            enabled = true;
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "inherit";
            cursor = mkLiteral "text";
            placeholder = "Search";
            placeholder-color = mkLiteral "inherit";
          };
          "mode-switcher" = {
            enabled = true;
            spacing = mkLiteral "10px";  
            margin = mkLiteral "10px";   
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "@foreground";
            orientation = mkLiteral "horizontal";
          };
          "button" = {
            padding = mkLiteral "15px";
            border-radius = mkLiteral "10px";
            background-color = mkLiteral "@bg-alt";
            text-color = mkLiteral "inherit";
            cursor = mkLiteral "pointer";
          };
          "button selected" = {
            background-color = mkLiteral "@selected";
            text-color = mkLiteral "@foreground";
          };
          "listview" = {
            enabled = true;
            columns = 1;
            lines = 8;
            cycle = true;
            dynamic = true;
            scrollbar = false;
            layout = mkLiteral "vertical";
            reverse = false;
            fixed-height = true;
            fixed-columns = true;
            spacing = mkLiteral "10px";
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "@foreground";
            cursor = "default";
          };
          "element" = {
            enabled = true;
            spacing = mkLiteral "15px";
            padding = mkLiteral "8px";
            border-radius = mkLiteral "10px";
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "@text-color";
            cursor = mkLiteral "pointer";
          };
          "element normal.normal" = {
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "@text-color";
          };
          "element normal.urgent" = {
            background-color = mkLiteral "@urgent";
            text-color = mkLiteral "@text-color";
          };
          "element normal.active" = {
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "@text-color";
          };
          "element selected.normal" = {
            background-color = mkLiteral "@selected";
            text-color = mkLiteral "@foreground";
          };
          "element selected.urgent" = {
            background-color = mkLiteral "@urgent";
            text-color = mkLiteral "@text-selected";
          };
          "element selected.active" = {
            background-color = mkLiteral "@urgent";
            text-color = mkLiteral "#000000";
          };
          "element-icon" = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "inherit";
            size = mkLiteral "36px";
            cursor = mkLiteral "inherit";
          };
          "element-text" = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "inherit";
            cursor = mkLiteral "inherit";
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.0";
          };
          "message" = {
            background-color = mkLiteral "transparent";
          };
          "textbox" = {
            padding = mkLiteral "15px";
            border-radius = mkLiteral "10px";
            background-color = mkLiteral "@bg-alt";
            text-color = mkLiteral "@foreground";
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.0";
          };
          "error-message" = {
            padding = mkLiteral "15px";
            border-radius = mkLiteral "20px";
            background-color = mkLiteral "@bg";
            text-color = mkLiteral "@foreground";
          };
        };
    };
  };
}
