{
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    # Window rules
    windowrule = [
      # Tags for different application types
      "tag +file-manager, class:^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)$"
      "tag +terminal, class:^(Alacritty|kitty|kitty-dropterm|com.mitchellh.ghostty|[Gg]hostty)$"
      "tag +browser, class:^(Brave-browser(-beta|-dev|-unstable)?)$"
      "tag +browser, class:^([Ff]irefox(-beta|-dev)?|org.mozilla.firefox|[Ff]irefox-esr)$"
      "tag +browser, class:^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$"
      "tag +browser, class:^([Tt]horium-browser|[Cc]achy-browser)$"
      "tag +browser, class:^(microsoft-edge)$"
      "tag +projects, class:^(codium|codium-url-handler|VSCodium)$"
      "tag +projects, class:^(VSCode|code-url-handler)$"
      "tag +im, class:^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$"
      "tag +im, class:^([Ff]erdium)$"
      "tag +im, class:^([Ww]hatsapp-for-linux)$"
      "tag +im, class:^(org.telegram.desktop|io.github.tdesktop_x64.TDesktop)$"
      "tag +im, class:^(teams-for-linux)$"
      "tag +games, class:^(gamescope)$"
      "tag +games, class:^(steam_app_\\d+)$"
      "tag +gamestore, class:^([Ss]team)$"
      "tag +gamestore, title:^([Ll]utris)$"
      "tag +gamestore, class:^(com.heroicgameslauncher.hgl)$"
      "tag +settings, class:^(gnome-disks|wihotspot(-gui)?)$"
      "tag +settings, class:^([Rr]ofi)$"
      "tag +settings, class:^(file-roller|org.gnome.FileRoller)$"
      "tag +settings, class:(.blueman-manager-wrapped)"
      "tag +settings, class:(nwg-displays)"
      "tag +settings, class:^(nm-applet|nm-connection-editor|blueman-manager)$"
      "tag +settings, class:^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$"
      "tag +settings, class:^(nwg-look|qt5ct|qt6ct|[Yy]ad)$"
      "tag +settings, class:(xdg-desktop-portal-gtk)"

      # Floating windows
      "float, tag:settings*"
      "float, class:^([Ff]erdium)$"
      "float, title:^(Picture-in-Picture)$"
      "float, class:^(mpv|com.github.rafostar.Clapper)$"
      "float, title:^(Authentication Required)$"
      "float, class:(codium|codium-url-handler|VSCodium), title:negative:(.*codium.*|.*VSCodium.*)"
      "float, class:^(com.heroicgameslauncher.hgl)$, title:negative:(Heroic Games Launcher)"
      "float, class:^([Ss]team)$, title:negative:^([Ss]team)$"
      "float, class:([Tt]hunar), title:negative:(.*[Tt]hunar.*)"
      "float, initialTitle:(Add Folder to Workspace)"
      "float, initialTitle:(Media viewer)"
      "float, initialTitle:(Open Files)"
      "float, initialTitle:(wants to save)"

      # Window positions and behaviors
      "move 60% 6%,title:^(Picture-in-Picture)$"
      "center, class:^([Ff]erdium)$"
      "center, class:^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$"
      "center, initialTitle:(Media viewer)"
      "center, class:([Tt]hunar), title:negative:(.*[Tt]hunar.*)"
      "center, title:^(Authentication Required)$"

      # Window sizes
      "size 86% 86%, initialTitle:(Media viewer)"
      "size 70% 60%, initialTitle:(Open Files)"
      "size 70% 60%, initialTitle:(Add Folder to Workspace)"
      "size 70% 70%, tag:settings*"
      "size 60% 70%, class:^([Ff]erdium)$"

      # Opacity rules
      "opacity 1.0 1.0, tag:browser*"
      "opacity 0.9 0.8, tag:projects*"
      "opacity 0.94 0.86, tag:im*"
      "opacity 0.9 0.8, tag:file-manager*"
      "opacity 0.88 0.8, tag:terminal*"
      "opacity 0.8 0.7, tag:settings*"
      "opacity 0.8 0.7, class:^(gedit|org.gnome.TextEditor|mousepad)$"
      "opacity 0.86 0.8, class:^(code|Code|code-oss)$"
      "opacity 0.9 0.8, class:^(seahorse)$"
      "opacity 1.0 1.0, title:^(Picture-in-Picture)$"

      # Special rules
      "pin, title:^(Picture-in-Picture)$"
      "keepaspectratio, title:^(Picture-in-Picture)$"
      "noblur, tag:games*"
      "fullscreen, tag:games*"
    ];
    # Layer rules for swaync blur effect
    layerrule = [
      "blur,logout_dialog"
      "blur,rofi"
      "ignorezero,rofi"
      "blur, swaync-control-center"
      "blur, swaync-notification-window"
      "blur, waybar"
      "ignorezero, waybar"
      "ignorezero, swaync-control-center"
      "ignorezero, swaync-notification-window"
      "ignorealpha 0.5, swaync-control-center"
      "ignorealpha 0.5, swaync-notification-window"
    ];
    # Miscellaneous settings
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
      "special:term, on-created-empty:ghostty"
      "special:term, gapsout:70 140 120 140,rounding:false, decorate:false, shadow:false"
      "special:obsidian, on-created-empty:obsidian"
      "special:obsidian, gapsout:20,rounding:false, decorate:false, shadow:false"
      "special:telegram, on-created-empty:telegram-desktop"
      "special:telegram, gapsout:26,rounding:false, decorate:false, shadow:false"
      "special:thunar, on-created-empty:thunar"
      "special:thunar, gapsout:26,rounding:false, decorate:false, shadow:false"
      "special:yazi, on-created-empty:ghostty --class=com.mitchellh.ghostty-yazi -e yazi"
      "special:yazi, gapsout:26,rounding:false, decorate:false, shadow:false"
    ];

    # Dwindle layout specific settings
    dwindle = {
      pseudotile = true; # Master window takes half the screen
      preserve_split = true; # Preserve split direction when closing windows
    };

  };
}
