{
  host,
  username,
  config,
  ...
}:
let
  inherit (import ../../../hosts/${host}/variables.nix)
    browser
    terminal
    extraMonitorSettings
    keyboardLayout
    ;
in
{
  wayland.windowManager.hyprland = {
    settings = {
      # XWayland settings
      # May affect scaling of some XWayland apps, needed for Steam resolution
      xwayland.force_zero_scaling = true;

      # Commands executed once on Hyprland startup
      exec-once = [
        "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "killall -q swww; sleep 0.5 && swww init"
        "killall -q waybar; sleep 0.5 && waybar"
        "killall -q swaync; sleep 0.5 && swaync"
        "oneshot" # dotfiles set and some configs
        # System tray applets and agents
        "nm-applet --indicator"
        "systemctl --user start hyprpolkitagent"
        # Pypr start
        "pypr &"
        # Set wallpaper (delay allows swww to initialize)
        "sleep 1.5 && swww img /home/${username}/Pictures/Wallpapers/pexels-harun-tan-2311991-3980364.jpg"
        # --- Autostart applications ---
        "${browser}" # Will be moved to workspace 1 by windowrule
        "protonvpn-app"
      ];

      # Input device settings
      input = {
        kb_layout = "${keyboardLayout}";
        kb_options = "caps:escape,grp:win_space_toggle"; # also need to be changed in services xkb
        numlock_by_default = true;
        repeat_delay = 300;
        follow_mouse = 1; # Focus follows mouse
        sensitivity = 0; # Mouse sensitivity (0 = default)
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          scroll_factor = 0.8;
        };
      };

      # General window manager settings
      general = {
        "$modifier" = "SUPER"; # Set the primary modifier key
        layout = "dwindle"; # Tiling layout engine
        gaps_in = 0; # Gaps between windows
        gaps_out = 0; # Gaps between windows and screen edges
        border_size = 1; # Window border size
        resize_on_border = true; # Allow resizing by dragging border
        # Border colors using Stylix theme variables
        "col.active_border" = "rgb(${config.lib.stylix.colors.base01})";
        "col.inactive_border" = "rgb(${config.lib.stylix.colors.base00})";
      };

      # Miscellaneous settings
      misc = {
        layers_hog_keyboard_focus = true; # Allow layers (like Rofi) to grab focus
        initial_workspace_tracking = 0; # Track initial workspace for applications
        mouse_move_enables_dpms = true; # Wake screen on mouse move
        key_press_enables_dpms = false; # Don't wake screen on key press
        disable_hyprland_logo = true; # Disable the startup logo
        disable_splash_rendering = true; # Disable the startup splash
      };

      # Dwindle layout specific settings
      dwindle = {
        pseudotile = true; # Master window takes half the screen
        preserve_split = true; # Preserve split direction when closing windows
      };

      # Window decoration settings
      decoration = {
        rounding = 0; # Window corner rounding
        blur = {
          enabled = true;
          size = 3;
          passes = 3;
          ignore_opacity = false;
          new_optimizations = true;
        };
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)"; # Shadow color
        };
      };

      # Gesture settings (for touchpads/touchscreens)
      gestures = {
        workspace_swipe = true; # Enable workspace swipe gestures
        workspace_swipe_invert = true; # Invert swipe direction
        workspace_swipe_forever = true; # Allow continuous swiping
      };

      # Animation settings
      animations = {
        enabled = true;
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];
      };

      # Keybind definitions
      bind = [
        # --- Application Launchers ---
        "$modifier,Return,exec,${terminal}" # Launch terminal
        "$modifier SHIFT,Return,exec,rofi-launcher" # Launch Rofi application launcher
        "$modifier ALT,W,exec,wallsetter" # Custom wallpaper setter script
        "$modifier,W,exec,${browser}" # Launch browser
        "$modifier SHIFT,E,exec,emopicker9000" # Emoji picker
        "$modifier,D,exec,discord" # Launch Discord
        "$modifier,O,exec,obs" # Launch OBS Studio
        "$modifier,C,exec,code" # Launch VS Code
        "$modifier,G,exec,gimp" # Launch GIMP
        "$modifier,N,exec,obsidian" # Launch Obsidian
        "$modifier,M,exec,pavucontrol" # Launch Pavucontrol (audio control)
        "$modifier,P,exec,hyprpicker -a" # Color picker (pick and copy)
        "$modifier,E,exec,pypr toggle thunar" # Toggle Thunar file manager (using pypr)
        "$modifier,T,exec,pypr toggle telegram-desktop" # Toggle Telegram (using pypr)
        "$modifier,R,exec,pypr toggle term" # Toggle Telegram (using pypr)
        "$modifier,Y,exec,pypr toggle yazi" # Toggle Yazi terminal file manager (using pypr)
        "$modifier,B,exec,pypr expose" # Expose windows (using pypr)
        # --- Window Management ---
        "$modifier,Q,killactive," # Close active window
        "$modifier SHIFT,P,pin," # Pin window (make sticky)
        "$modifier SHIFT,I,togglesplit," # Toggle dwindle layout split direction
        "$modifier,F,fullscreen," # Toggle fullscreen
        "$modifier SHIFT,F,togglefloating," # Toggle floating state for a window
        "$modifier ALT,F,workspaceopt, allfloat" # Toggle all windows on workspace to float
        "$modifier SHIFT,left,movewindow,l" # Move window left
        "$modifier SHIFT,right,movewindow,r" # Move window right
        "$modifier SHIFT,up,movewindow,u" # Move window up
        "$modifier SHIFT,down,movewindow,d" # Move window down
        "$modifier SHIFT,h,movewindow,l" # Move window left (vim key)
        "$modifier SHIFT,l,movewindow,r" # Move window right (vim key)
        "$modifier SHIFT,k,movewindow,u" # Move window up (vim key)
        "$modifier SHIFT,j,movewindow,d" # Move window down (vim key)
        "$modifier,left,movefocus,l" # Move focus left
        "$modifier,right,movefocus,r" # Move focus right
        "$modifier,up,movefocus,u" # Move focus up
        "$modifier,down,movefocus,d" # Move focus down
        "$modifier,h,movefocus,l" # Move focus left (vim key)
        "$modifier,l,movefocus,r" # Move focus right (vim key)
        "$modifier,k,movefocus,u" # Move focus up (vim key)
        "$modifier,j,movefocus,d" # Move focus down (vim key)
        # --- Workspace Management ---
        "$modifier,1,workspace,1" # Switch to workspace 1
        "$modifier,2,workspace,2" # Switch to workspace 2
        "$modifier,3,workspace,3" # Switch to workspace 3
        "$modifier,4,workspace,4" # Switch to workspace 4
        "$modifier,5,workspace,5" # Switch to workspace 5
        "$modifier,6,workspace,6" # Switch to workspace 6
        "$modifier,7,workspace,7" # Switch to workspace 7
        "$modifier,8,workspace,8" # Switch to workspace 8
        "$modifier,9,workspace,9" # Switch to workspace 9
        "$modifier,0,workspace,10" # Switch to workspace 10
        "$modifier,F1,workspace,6" # Switch to workspace 6 (alternative)
        "$modifier,F2,workspace,7" # Switch to workspace 7 (alternative)
        "$modifier,F3,workspace,8" # Switch to workspace 8 (alternative)
        "$modifier,F4,workspace,9" # Switch to workspace 9 (alternative)
        "$modifier,F5,workspace,10" # Switch to workspace 10 (alternative)
        "$modifier SHIFT,S,movetoworkspace,special" # Move window to special workspace
        "$modifier,S,togglespecialworkspace" # Toggle visibility of special workspace
        "$modifier SHIFT,1,movetoworkspace,1" # Move window to workspace 1
        "$modifier SHIFT,2,movetoworkspace,2" # Move window to workspace 2
        "$modifier SHIFT,3,movetoworkspace,3" # Move window to workspace 3
        "$modifier SHIFT,4,movetoworkspace,4" # Move window to workspace 4
        "$modifier SHIFT,5,movetoworkspace,5" # Move window to workspace 5
        "$modifier SHIFT,6,movetoworkspace,6" # Move window to workspace 6
        "$modifier SHIFT,7,movetoworkspace,7" # Move window to workspace 7
        "$modifier SHIFT,8,movetoworkspace,8" # Move window to workspace 8
        "$modifier SHIFT,9,movetoworkspace,9" # Move window to workspace 9
        "$modifier SHIFT,0,movetoworkspace,10" # Move window to workspace 10
        "$modifier SHIFT,F1,movetoworkspace,6" # Move window to workspace 6 (alternative)
        "$modifier SHIFT,F2,movetoworkspace,7" # Move window to workspace 7 (alternative)
        "$modifier SHIFT,F3,movetoworkspace,8" # Move window to workspace 8 (alternative)
        "$modifier SHIFT,F4,movetoworkspace,9" # Move window to workspace 9 (alternative)
        "$modifier SHIFT,F5,movetoworkspace,10" # Move window to workspace 10 (alternative)
        "$modifier CONTROL,right,workspace,e+1" # Switch to next workspace
        "$modifier CONTROL,left,workspace,e-1" # Switch to previous workspace
        "$modifier,mouse_down,workspace, e+1" # Switch to next workspace (mouse scroll down)
        "$modifier,mouse_up,workspace, e-1" # Switch to previous workspace (mouse scroll up)
        "ALT,Tab,cyclenext," # Cycle focus to next window
        "ALT,Tab,bringactivetotop," # Bring the newly focused window to top
        # --- System & Media Keys ---
        "ALT,SHIFT,exec,hyprctl switchxkblayout at-translated-set-2-keyboard next" # Switch keyboard layout
        ",PRINT,exec,screenshootin" # Screenshot script
        "$modifier SHIFT,N,exec,swaync-client -rs" # Toggle notification center (swaync)
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" # Toggle mute
        ",XF86TouchpadToggle , exec, toggle_touchpad" # Custom touchpad toggle script
        ",XF86AudioPlay, exec, playerctl play-pause" # Play/Pause media
        ",XF86AudioPause, exec, playerctl play-pause" # Play/Pause media (duplicate for some keyboards)
        ",XF86AudioNext, exec, playerctl next" # Next track
        ",XF86AudioPrev, exec, playerctl previous" # Previous track
        "$modifier SHIFT,C,exit," # Exit Hyprland (alternative, immediate)
      ];

      # For repeateable actions on
      binde = [
        ",XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+" # Increase volume
        ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-" # Decrease volume
        ",XF86MonBrightnessDown,exec,brightnessctl set 1%-" # Decrease brightness
        ",XF86MonBrightnessUp,exec,brightnessctl set 1%+" # Increase brightness
        "SHIFT,XF86MonBrightnessDown,exec,brightnessctl -d asus::kbd_backlight s 1%-" # Decrease keyboard brightness (only asus device for else brghtnessctl -l)
        "SHIFT,XF86MonBrightnessUp,exec,brightnessctl -d asus::kbd_backlight s 1%+" # Increase keyboard brightness (only asus device)

      ];
      # Mouse button bindings
      bindm = [
        "$modifier, mouse:272, movewindow" # Move window with Mod + Left Mouse Button
        "$modifier, mouse:273, resizewindow" # Resize window with Mod + Right Mouse Button
      ];

      windowrulev2 = [
        "tag +file-manager, class:^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)$"
        "tag +terminal, class:^(Alacritty|kitty|kitty-dropterm|com.mitchellh.ghostty|[Gg]hostty)$"
        "tag +browser, class:^(Brave-browser(-beta|-dev|-unstable)?)$"
        "tag +browser, class:^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr)$"
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
        "tag +games, class:^(steam_app_\d+)$"
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
        "move 72% 7%,title:^(Picture-in-Picture)$"
        "center, class:^([Ff]erdium)$"
        "center, class:^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$"
        "center, class:([Tt]hunar), title:negative:(.*[Tt]hunar.*)" # Center Thunar dialogs
        "center, title:^(Authentication Required)$"
        "idleinhibit fullscreen, class:^(*)$" # Inhibit idle when any app is fullscreen
        "idleinhibit fullscreen, title:^(*)$" # Inhibit idle when any window title matches (less reliable)
        "idleinhibit fullscreen, fullscreen:1" # Inhibit idle when fullscreen state is active
        "float, tag:settings*" # Float windows tagged as settings
        "float, class:^([Ff]erdium)$"
        "float, title:^(Picture-in-Picture)$"
        "float, class:^(mpv|com.github.rafostar.Clapper)$" # Float video players
        "float, title:^(Authentication Required)$"
        "float, class:(codium|codium-url-handler|VSCodium), title:negative:(.*codium.*|.*VSCodium.*)" # Float VS Codium dialogs
        "float, class:^(com.heroicgameslauncher.hgl)$, title:negative:(Heroic Games Launcher)" # Float Heroic dialogs
        "float, class:^([Ss]team)$, title:negative:^([Ss]team)$" # Float Steam dialogs
        "float, class:([Tt]hunar), title:negative:(.*[Tt]hunar.*)" # Float Thunar dialogs
        "float, initialTitle:(Add Folder to Workspace)" # Float specific VS Code dialogs
        "float, initialTitle:(Open Files)"
        "float, initialTitle:(wants to save)"
        "size 70% 60%, initialTitle:(Open Files)" # Size specific dialogs
        "size 70% 60%, initialTitle:(Add Folder to Workspace)"
        "size 70% 70%, tag:settings*" # Default size for settings windows
        "size 60% 70%, class:^([Ff]erdium)$" # Default size for Ferdium
        "opacity 1.0 1.0, tag:browser*" # Opacity rules
        "opacity 0.9 0.8, tag:projects*"
        "opacity 0.94 0.86, tag:im*"
        "opacity 0.9 0.8, tag:file-manager*"
        "opacity 0.8 0.7, tag:terminal*"
        "opacity 0.8 0.7, tag:settings*"
        "opacity 0.8 0.7, class:^(gedit|org.gnome.TextEditor|mousepad)$" # Text editors
        "opacity 0.9 0.8, class:^(seahorse)$" # Seahorse (GNOME Keyring)
        "opacity 0.95 0.75, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$" # Pin Picture-in-Picture window
        "keepaspectratio, title:^(Picture-in-Picture)$" # Maintain aspect ratio for PiP
        "noblur, tag:games*" # Disable blur for games
        "fullscreen, tag:games*" # Force fullscreen for games
      ];

      # Environment variables set for the Hyprland session
      env = [
        "NIXOS_OZONE_WL, 1" # Enable Wayland backend for Ozone-based apps (Electron)
        "NIXPKGS_ALLOW_UNFREE, 1" # Allow unfree packages if needed
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
        "GDK_BACKEND, wayland, x11" # Prefer Wayland for GTK apps, fallback to X11
        "CLUTTER_BACKEND, wayland" # Prefer Wayland for Clutter apps
        "QT_QPA_PLATFORM=wayland;xcb" # Prefer Wayland for Qt apps, fallback to XCB (X11)
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1" # Use server-side decorations for Qt Wayland apps
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1" # Auto-scaling for Qt apps
        "SDL_VIDEODRIVER, wayland,x11" # Prefer Wayland for SDL apps (Corrected from just x11)
        "EDITOR,nvim" # Default editor
        "MOZ_ENABLE_WAYLAND, 1" # Force Wayland backend for Firefox
        "AQ_DRM_DEVICES,/dev/dri/card0:/dev/dri/card1" # Example for multi-GPU setups (adjust if needed)
        # Explicit scaling factors (might override auto-scaling, use with caution)
        "GDK_SCALE,1"
        "QT_SCALE_FACTOR,1"
        "WINIT_X11_SCALE_FACTOR,1"
        "QT_AUTO_SCREEN_SCALE_FACTOR,0" # Disable auto screen scale factor if setting manually
        "QT_SCREEN_SCALE_FACTORS,1" # Manual screen scale factor for Qt
      ];
    };

    # Monitor configuration (preferred resolution, auto position, auto scale)
    extraConfig = ''
      monitor=,preferred,auto,auto
      ${extraMonitorSettings}
    '';
  };
}
