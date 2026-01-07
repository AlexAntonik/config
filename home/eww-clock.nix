{ pkgs, ... }:
let
  eww-config = pkgs.runCommand "eww-config" { } ''
        mkdir -p $out
        
        cat > $out/eww.yuck <<'EOF'
    (defwindow clock
      :monitor 0
      :geometry (geometry :x "40px" :y "0px" :width "500px" :height "160px" :anchor "bottom right")
      :stacking "bg"
      :exclusive false
      :focusable false
      :reserve (struts :distance "0px" :side "bottom")
      (box
        :class "wallpaper-clock"
        :orientation "vertical"
        :halign "end"
        :valign "end"
        (label :class "time-display" :text {formattime(EWW_TIME, "%H:%M")})
        (label :class "date-display" :text {formattime(EWW_TIME, "%A, %d %B")})))

    (defwindow temp-clock
      :monitor 0
      :geometry (geometry :x "0px" :y "0px" :width "500px" :height "160px" :anchor "center center")
      :stacking "overlay"
      :exclusive false
      :focusable false
      (box
        :class "wallpaper-clock"
        :orientation "vertical"
        :halign "center"
        :valign "center"
        (label :class "time-display" :text {formattime(EWW_TIME, "%H:%M")})
        (label :class "date-display" :text {formattime(EWW_TIME, "%A, %d %B")})))
    EOF

        cat > $out/eww.css <<'EOF'
    * {
      all: unset;
      font-family: "JetBrains Mono", "DejaVu Sans Mono", "Liberation Mono", monospace;
      font-weight: normal;
    }

    window {
      background-color: transparent;
    }

    .wallpaper-clock {
      background-color: transparent;
      background: transparent;
    }

    .time-display {
      font-size: 120px;
      font-weight: bold;
      color: #cccccc;
      text-shadow:
        4px 4px 6px rgba(0, 0, 0, 0.7);
      letter-spacing: -3px;
      margin-bottom: -40px;
    }
    .date-display {
      font-size: 32px;
      font-weight: normal;
      color: rgba(255, 255, 255, 0.8);
      text-shadow: 3px 3px 15px rgba(0, 0, 0, 0.6);
      letter-spacing: 1px;
    }
    EOF
  '';
in
{

  home.packages = [
    (pkgs.writeShellScriptBin "show-clock" ''
      eww open temp-clock
      sleep 2
      eww close temp-clock
    '')
  ];
  programs.eww = {
    enable = true;
    package = pkgs.eww;
    configDir = eww-config;
  };

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "eww daemon"
    ];
  };
}
