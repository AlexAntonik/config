{ pkgs, ... }:

pkgs.writeShellScriptBin "wallsetter" ''
  TIMEOUT=720
  LAST_WALLPAPER_FILE="/tmp/last_wallpaper"

  for pid in $(pidof -o %PPID -x wallsetter); do
    kill $pid
  done

  if ! [ -d ~/Pictures/Wallpapers ]; then 
    notify-send -t 5000 "~/Pictures/Wallpapers does not exist" && exit 1
  fi
  
  if [ $(ls -1 ~/Pictures/Wallpapers | wc -l) -lt 1 ]; then
    notify-send -t 9000 "The wallpaper folder is expected to have more than 1 image. Exiting Wallsetter." && exit 1
  fi

  # Читаем последние обои из файла
  CURRENT_WALLPAPER=""
  [ -f "$LAST_WALLPAPER_FILE" ] && CURRENT_WALLPAPER=$(cat "$LAST_WALLPAPER_FILE")
  
  # Выбираем новые обои, отличные от текущих
  WALLPAPER=$CURRENT_WALLPAPER
  while [ "$WALLPAPER" = "$CURRENT_WALLPAPER" ]; do
    WALLPAPER=$(find ~/Pictures/Wallpapers -name '*' | awk '!/.git/' | tail -n +2 | shuf -n 1)
  done

  # Сохраняем новые обои в файл
  echo "$WALLPAPER" > "$LAST_WALLPAPER_FILE"

  ${pkgs.swww}/bin/swww img "$WALLPAPER" --transition-type random --transition-step 1 --transition-fps 60
''
