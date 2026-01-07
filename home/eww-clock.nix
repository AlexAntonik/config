{ pkgs, ... }:

let
  eww-config = pkgs.runCommand "eww-config" { } ''
        mkdir -p $out

        cat > $out/eww.yuck <<'EOF'
    (defwindow clock
      :monitor 0
      :geometry (geometry :x "40px" :y "0px" :width "500px" :height "160px" :anchor "bottom right")
      :stacking "bg"
      (clock-widget :halign "end" :valign "end"))

    (defwindow temp-clock
      :monitor 0
      :geometry (geometry :width "500px" :height "160px" :anchor "center center")
      :stacking "overlay"
      (clock-widget :halign "center" :valign "center"))

    (defwidget clock-widget [halign valign]
      (box
        :class "wallpaper-clock"
        :orientation "vertical"
        :halign halign
        :valign valign
        (label :class "time-display" :text {formattime(EWW_TIME, "%H:%M")})
        (label :class "date-display" :text {formattime(EWW_TIME, "%A, %d %B")})))
    EOF

        cat > $out/eww.css <<'EOF'
    * {
      all: unset;
      font-family: "JetBrains Mono", monospace;
    }

    window {
      background: transparent;
    }

    .time-display {
      font-size: 120px;
      font-weight: bold;
      color: #cccccc;
      text-shadow: 4px 4px 6px rgba(0,0,0,0.7);
      letter-spacing: -3px;
      margin-bottom: -40px;
    }

    .date-display {
      font-size: 32px;
      color: rgba(255,255,255,0.8);
      text-shadow: 3px 3px 15px rgba(0,0,0,0.6);
      letter-spacing: 1px;
    }
    EOF
  '';
in
{
  programs.eww = {
    enable = true;
    configDir = eww-config;
  };

  home.packages = [
    (pkgs.writeShellScriptBin "show-clock" ''
      eww open temp-clock
      sleep 2
      eww close temp-clock
    '')
  ];

  wayland.windowManager.hyprland.settings.exec-once = [
    "eww daemon"
  ];
}
