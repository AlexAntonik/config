{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.yt-dlp ];
  environment.shellAliases = {
    ytdm = "noglob yt-dlp -t aac --embed-thumbnail -o \"~/Music/%(title)s\"";
    ytdv = "noglob yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' --embed-thumbnail -o \"~/Videos/%(title)s.%(ext)s\"";
    ytdp = "noglob yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' --embed-thumbnail -o \"~/Videos/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s\"";
  };
}
