{
  wayland.windowManager.hyprland.settings = {
    # Window rules
    windowrule = [
      "tag +file-manager, match:class ([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)"
      "tag +terminal, match:class (Alacritty|kitty|kitty-dropterm|com.mitchellh.ghostty|[Gg]hostty)"
      "tag +msg, match:class ([Dd]iscord|[Ww]ebCord|[Vv]esktop)"
      "tag +msg, match:class (org.telegram.desktop|io.github.tdesktop_x64.TDesktop)"
      "tag +msg, match:class teams-for-linux"
      "tag +games, match:class gamescope"
      "tag +games, match:class steam_app_\\d+"
      "tag +gamestore, match:class [Ss]team"
      "tag +gamestore, match:title [Ll]utris"
      "tag +gamestore, match:class com.heroicgameslauncher.hgl"
      "tag +settings, match:class (gnome-disks|wihotspot(-gui)?)"
      "tag +settings, match:class [Rr]ofi"
      "tag +settings, match:class (file-roller|org.gnome.FileRoller)"
      "tag +settings, match:class .blueman-manager-wrapped"
      "tag +settings, match:class nwg-displays"
      "tag +settings, match:class (nm-applet|nm-connection-editor|blueman-manager)"
      "tag +settings, match:class (pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)"
      "tag +settings, match:class (nwg-look|qt5ct|qt6ct|[Yy]ad)"
      "tag +settings, match:class xdg-desktop-portal-gtk"

      "float on, match:tag settings*"
      "float on, match:title Picture-in-Picture"
      "float on, match:title Authentication Required"
      "float on, match:class (codium|codium-url-handler|VSCodium), match:title negative:.*codium.*|.*VSCodium.*"
      "float on, match:class com.heroicgameslauncher.hgl, match:title negative:Heroic Games Launcher"
      "float on, match:class [Ss]team, match:title negative:[Ss]team"
      "float on, match:class [Tt]hunar, match:title negative:.*[Tt]hunar.*"
      "float on, match:initial_title Add Folder to Workspace"
      "float on, match:initial_title Media viewer"
      "float on, match:initial_title Open Files"
      "float on, match:initial_title wants to save"

      "move 60% 6%, match:title Picture-in-Picture"
      "center on, match:class (pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)"
      "center on, match:initial_title Media viewer"
      "center on, match:class [Tt]hunar, match:title negative:.*[Tt]hunar.*"
      "center on, match:title Authentication Required"

      "size 86% 86%, match:initial_title Media viewer"
      "size 70% 60%, match:initial_title Open Files"
      "size 70% 60%, match:initial_title Add Folder to Workspace"
      "size 70% 70%, match:tag settings*"
      "size 60% 70%, match:class [Ff]erdium"

      "opacity 0.86, match:tag msg*"
      "opacity 0.9, match:tag file-manager*"
      "opacity 0.86, match:tag terminal*"
      "opacity 0.8, match:tag settings*"
      "opacity 0.86, match:class (code|Code|code-oss)"
      "opacity 1.0 override, match:title Picture-in-Picture"

      "pin on, match:title Picture-in-Picture"
      "no_blur on, match:tag games*"
      "fullscreen on, match:tag games*"
    ];

    layerrule = [
      "blur on, match:namespace vicinae"
      "blur on, match:namespace noctalia-background-.*"
      "ignore_alpha 0.5, match:namespace noctalia-background-.*"
      "ignore_alpha 0, match:namespace vicinae"
    ];
    misc = {
      layers_hog_keyboard_focus = true; # Allow layers (like Rofi) to grab focus
      focus_on_activate = true;
      initial_workspace_tracking = 0; # Track initial workspace for applications
      mouse_move_enables_dpms = true; # Wake screen on mouse move
      key_press_enables_dpms = false; # Don't wake screen on key press
      disable_hyprland_logo = true; # Disable the startup logo
      disable_splash_rendering = true; # Disable the startup splash

      #  Application not responding (ANR) settings
      enable_anr_dialog = true;
      anr_missed_pings = 20;
    };

    workspace = [
      "6,monitor:HDMI-A-1, default:true"
      "2, on-created-empty:code"
      "special:term, on-created-empty:ghostty +new-window"
      "special:term, gapsout:70 140 120 140,rounding:false, decorate:false, shadow:false"
      "special:obsidian, on-created-empty:obsidian"
      "special:obsidian, gapsout:20,rounding:false, decorate:false, shadow:false"
      "special:discord, on-created-empty:discord"
      "special:discord, gapsout:20,rounding:false, decorate:false, shadow:false"
      "special:telegram, on-created-empty:Telegram"
      "special:telegram, gapsout:26,rounding:false, decorate:false, shadow:false"
      "special:thunar, on-created-empty:thunar"
      "special:thunar, gapsout:26,rounding:false, decorate:false, shadow:false"
      "special:yazi, on-created-empty:ghostty --class=com.mitchellh.ghostty-yazi -e yazi +new-window"
      "special:yazi, gapsout:26,rounding:false, decorate:false, shadow:false"
    ];

    # Dwindle layout specific settings
    dwindle = {
      pseudotile = true; # Master window takes half the screen
      preserve_split = true; # Preserve split direction when closing windows
    };

  };
}
