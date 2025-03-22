{ pkgs, ... }:

let
  protonvpnKeepaliveScript = ''
    #!/bin/bash
    set -e

    # Get interface information
    WG_OUTPUT=$(wg show proton0)

    # Get peer key directly
    PEER_LINE=$(echo "$WG_OUTPUT" | grep "^peer:" | head -n1)
    PEER_KEY=$(echo "$PEER_LINE" | cut -d' ' -f2)
    
    if [ -n "$PEER_KEY" ]; then
      if ! echo "$WG_OUTPUT" | grep -q "persistent keepalive: "; then
        wg set proton0 peer "$PEER_KEY" persistent-keepalive 25
      fi
    fi
    exit 0
  '';
in
{
  environment.etc."protonvpn-keepalive.sh".text = protonvpnKeepaliveScript;

  systemd.services.protonvpn-keepalive = {
    description = "Sets persistent-keepalive for ProtonVPN";
    script = "${protonvpnKeepaliveScript}";
    path = with pkgs; [ 
      wireguard-tools
    ];
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };

  systemd.timers.protonvpn-keepalive = {
    description = "Timer for protonvpn-keepalive service";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "10s";
      OnUnitActiveSec = "10s";
    };
  };
}
