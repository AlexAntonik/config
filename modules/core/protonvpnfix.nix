{ pkgs, ... }:

let
  protonvpnKeepaliveScript = ''
    #!/bin/bash

    # Функция для логирования
    log() {
      echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> /var/log/protonvpn-keepalive.log
    }

    # Проверяем наличие утилиты wg
    if ! command -v wg &> /dev/null; then
      log "Утилита wireguard не установлена"
      exit 1
    fi

    # Проверяем интерфейс и получаем информацию
    WG_OUTPUT=$(wg show proton0 2>&1)
    if [ $? -eq 0 ] && echo "$WG_OUTPUT" | grep -q "interface: proton0"; then
      log "Интерфейс proton0 найден"
      
      # Извлекаем публичный ключ первого пира
      peer_key=$(echo "$WG_OUTPUT" | awk '/peer:/ {print $2; exit}')
      
      if [ -n "$peer_key" ]; then
        # Проверяем, установлен ли уже keepalive
        has_keepalive=$(echo "$WG_OUTPUT" | grep -A7 "peer: $peer_key" | grep "persistent keepalive:")
        
        if [ -z "$has_keepalive" ]; then
          log "Устанавливаем keepalive для пира $peer_key"
          wg set proton0 peer "$peer_key" persistent-keepalive 25
          if [ $? -eq 0 ]; then
            log "Keepalive успешно установлен"
          else
            log "Ошибка при установке keepalive"
          fi
        else
          log "Keepalive уже установлен для пира $peer_key"
        fi
      else
        log "Пир не найден для интерфейса proton0"
      fi
    else
      log "Интерфейс proton0 не найден или не активен. Ошибка: $WG_OUTPUT"
    fi
  '';
in
{
  environment.etc."protonvpn-keepalive.sh".text = protonvpnKeepaliveScript;

  systemd.services.protonvpn-keepalive = {
    description = "Устанавливает persistent-keepalive для ProtonVPN";
    script = "${protonvpnKeepaliveScript}";
    path = with pkgs; [ 
      wireguard-tools
      gawk
    ];
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };

  systemd.timers.protonvpn-keepalive = {
    description = "Таймер для сервиса protonvpn-keepalive";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "10s";
      OnUnitActiveSec = "10s";
    };
  };
}
