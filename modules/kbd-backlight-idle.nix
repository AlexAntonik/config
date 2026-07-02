{ pkgs, host, ... }:
let
  script = pkgs.writeShellScript "kbd-backlight-idle" ''
    state_file=/run/user/$(id -u)/kbd-backlight-state

    ${pkgs.swayidle}/bin/swayidle -w \
      timeout ${host.kbdIdleTimeout} \
        '${pkgs.bash}/bin/bash -c "
          ${pkgs.brightnessctl}/bin/brightnessctl -d ${host.keyboardLightID} g > $state_file.kbd;
          ${pkgs.brightnessctl}/bin/brightnessctl -d ${host.keyboardLightID} s 0;
        "' \
      resume \
        '${pkgs.bash}/bin/bash -c "
          ${pkgs.brightnessctl}/bin/brightnessctl -d ${host.keyboardLightID} s $(cat $state_file.kbd);
        "'
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
