{ ... }:
{
  environment.etc."protonvpn_keepalive.sh" = {
    text = ''
      #!/usr/bin/env bash
      if ! ip link show proton0 &>/dev/null; then
        exit 0
      fi

      peer_key=$(wg show proton0 | awk '/peer:/ {print $2; exit}')

      if [ -n "$peer_key" ]; then
        wg set proton0 peer "$peer_key" persistent-keepalive 25
      fi
    '';
    mode = "0755";
  };

  systemd.services.protonvpn-keepalive = {
    description = "Установка persistent-keepalive для ProtonVPN";
    serviceConfig.Type = "oneshot";
    script = "/etc/protonvpn_keepalive.sh";
  };

  systemd.timers.protonvpn-keepalive = {
    description = "Таймер для установки persistent-keepalive для ProtonVPN";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "3sec";
      OnUnitActiveSec = "3sec";
    };
    unit = "protonvpn-keepalive.service";
  };
}
