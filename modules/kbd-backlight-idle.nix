{ kbdIdleTimeout, keyboardLightID }:
{ pkgs, ... }:
let
  script = pkgs.writeShellScript "kbd-backlight-idle" ''
    state_file="/run/user/$(id -u)/kbd-backlight-state.kbd"

    ${pkgs.swayidle}/bin/swayidle -w \
      timeout ${kbdIdleTimeout} \
        "${pkgs.brightnessctl}/bin/brightnessctl -d ${keyboardLightID} g > \"$state_file\"; \
         ${pkgs.brightnessctl}/bin/brightnessctl -d ${keyboardLightID} s 0" \
      resume \
        "current=\$(${pkgs.brightnessctl}/bin/brightnessctl -d ${keyboardLightID} g); \
         if [ \"\$current\" -eq 0 ]; then \
           [ -f \"$state_file\" ] && \
           ${pkgs.brightnessctl}/bin/brightnessctl -d ${keyboardLightID} s \$(cat \"$state_file\"); \
         else \
           echo \"\$current\" > \"$state_file\"; \
         fi"
  '';
in
{
  systemd.user.services.kbd-backlight-idle = {
    description = "Turn off keyboard backlight and light indicator LED after idle";
    wantedBy = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "${script}";
      Restart = "always";
      RestartSec = "5sec";
      Nice = 19;
      Type = "simple";
    };
  };
}
