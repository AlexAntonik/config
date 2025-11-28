{
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    rofimoji
  ];
  programs = {
    rofi = {
      enable = true;
      package = pkgs.rofi;
      plugins = with pkgs; [
        unstable.rofi-calc
      ];
      extraConfig = {
        show-icons = true;
        icon-theme = "Papirus";
        font = "JetBrainsMono Nerd Font Mono 12";
        drun-display-format = "{icon} {name}";
      };
      theme =
        let
          inherit (config.lib.formats.rasi) mkLiteral;
        in
        {
          "*" = {
            bg = mkLiteral "rgba(50, 50, 50, 0.4)";
            bg-alt = mkLiteral "rgba(86, 86, 86, 0.4)";
            foreground = mkLiteral "rgba(204, 204, 204, 0.6)";
            selected = mkLiteral "rgba(155, 155, 155, 0.62)";
            text-selected = mkLiteral "rgba(205, 205, 205, 1)";
            text-color = mkLiteral "rgba(212, 212, 212, 0.85)";
            border-color = mkLiteral "rgba(136, 136, 136, 0.6)";
            transparent = mkLiteral "rgba(0, 0, 0, 0)";
          };
          "window" = {
            transparency = "real";
            width = mkLiteral "500px";
            location = mkLiteral "center";
            anchor = mkLiteral "center";
            x-offset = mkLiteral "0px";
            y-offset = mkLiteral "0px";
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
            str = "";
            background-color = mkLiteral "@transparent";
            text-color = mkLiteral "inherit";
          };
          "entry" = {
            enabled = true;
            background-color = mkLiteral "@transparent";
            text-color = mkLiteral "inherit";
            cursor = mkLiteral "text";
            placeholder = "Search";
            placeholder-color = mkLiteral "inherit";
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
          "element selected.normal" = {
            background-color = mkLiteral "@selected";
            text-color = mkLiteral "@text-selected";
          };
          "element-icon" = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "inherit";
            size = mkLiteral "36px";
          };
          "element-text" = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "inherit";
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
