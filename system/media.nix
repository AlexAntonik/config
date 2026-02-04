{
  flake.nixosModules.media =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        ffmpeg # Terminal video/audio editing
        pavucontrol # PulseAudio volume control
        pamixer # Command-line mixer for PulseAudio
        easyeffects # Audio effects for PipeWire
        playerctl # Media player controller
        v4l-utils # Video4Linux utilities
      ];

      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        audio.enable = true;
        jack.enable = true;
        wireplumber.enable = true;
      };
    };
}
