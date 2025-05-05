{
  host,
  ...
}:
let
  inherit (import ../../hosts/${host}/variables.nix)
    browser
    terminal
    keyboardLightID
    ;
in
{
  wayland.windowManager.hyprland.settings = {
    # Gesture settings (for touchpads/touchscreens)
    gestures = {
      workspace_swipe = true; # Enable workspace swipe gestures
      workspace_swipe_invert = true; # Invert swipe direction
      workspace_swipe_forever = true; # Allow continuous swiping
    };

    # Keybindings
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
      "$modifier,M,exec,pavucontrol" # Launch Pavucontrol
      "$modifier,V,exec,cliphist list | rofi -dmenu | cliphist decode | wl-copy" # clipboard mgr
      "$modifier,P,exec,hyprpicker -a" # Color picker
      "$modifier,E,exec,pypr toggle thunar" # Toggle Thunar file manager
      "$modifier,T,exec,pypr toggle telegram-desktop" # Toggle Telegram
      "$modifier,R,exec,pypr toggle term" # Toggle terminal
      "$modifier,Y,exec,pypr toggle yazi" # Toggle Yazi

      # --- Window Management ---
      "$modifier,Q,killactive," # Close active window
      "$modifier SHIFT,P,pin," # Pin window
      "$modifier SHIFT,I,togglesplit," # Toggle split
      "$modifier,F,fullscreen," # Toggle fullscreen
      "$modifier SHIFT,F,togglefloating," # Toggle floating
      "$modifier ALT,F,workspaceopt, allfloat" # Toggle all floating

      # --- Window Movement ---
      "$modifier SHIFT,left,movewindow,l"
      "$modifier SHIFT,right,movewindow,r"
      "$modifier SHIFT,up,movewindow,u"
      "$modifier SHIFT,down,movewindow,d"
      "$modifier SHIFT,h,movewindow,l"
      "$modifier SHIFT,l,movewindow,r"
      "$modifier SHIFT,k,movewindow,u"
      "$modifier SHIFT,j,movewindow,d"

      # --- Focus Movement ---
      "$modifier,left,movefocus,l"
      "$modifier,right,movefocus,r"
      "$modifier,up,movefocus,u"
      "$modifier,down,movefocus,d"
      "$modifier,h,movefocus,l"
      "$modifier,l,movefocus,r"
      "$modifier,k,movefocus,u"
      "$modifier,j,movefocus,d"

      # --- Workspace Management ---
      "$modifier,1,workspace,1"
      "$modifier,2,workspace,2"
      "$modifier,3,workspace,3"
      "$modifier,4,workspace,4"
      "$modifier,5,workspace,5"
      "$modifier,6,workspace,6"
      "$modifier,7,workspace,7"
      "$modifier,8,workspace,8"
      "$modifier,9,workspace,9"
      "$modifier,0,workspace,10"
      "$modifier,F1,workspace,6"
      "$modifier,F2,workspace,7"
      "$modifier,F3,workspace,8"
      "$modifier,F4,workspace,9"
      "$modifier,F5,workspace,10"
      "$modifier,S,togglespecialworkspace"

      # --- Move to Workspace ---
      "$modifier SHIFT,S,movetoworkspace,special"
      "$modifier SHIFT,1,movetoworkspace,1"
      "$modifier SHIFT,2,movetoworkspace,2"
      "$modifier SHIFT,3,movetoworkspace,3"
      "$modifier SHIFT,4,movetoworkspace,4"
      "$modifier SHIFT,5,movetoworkspace,5"
      "$modifier SHIFT,6,movetoworkspace,6"
      "$modifier SHIFT,7,movetoworkspace,7"
      "$modifier SHIFT,8,movetoworkspace,8"
      "$modifier SHIFT,9,movetoworkspace,9"
      "$modifier SHIFT,0,movetoworkspace,10"
      "$modifier SHIFT,F1,movetoworkspace,6"
      "$modifier SHIFT,F2,movetoworkspace,7"
      "$modifier SHIFT,F3,movetoworkspace,8"
      "$modifier SHIFT,F4,movetoworkspace,9"
      "$modifier SHIFT,F5,movetoworkspace,10"

      # --- Workspace Navigation ---
      "$modifier CONTROL,right,workspace,e+1"
      "$modifier CONTROL,left,workspace,e-1"
      "$modifier,mouse_down,workspace, e+1"
      "$modifier,mouse_up,workspace, e-1"
      "ALT,Tab,cyclenext,"
      "ALT,Tab,bringactivetotop,"

      # --- System Controls ---
      ",PRINT,exec,screenshootin"
      "$modifier SHIFT,N,exec,swaync-client -rs"
      ",XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
      ",XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"
      ",XF86TouchpadToggle , exec, toggle_touchpad"
      ",XF86AudioPlay, exec, playerctl play-pause"
      ",XF86AudioPause, exec, playerctl play-pause"
      ",XF86AudioNext, exec, playerctl next"
      ",XF86AudioPrev, exec, playerctl previous"
      "$modifier SHIFT,C,exit,"
      ",XF86WebCam,exec,toggle_display"
    ];

    # Repeatable actions
    binde = [
      "SHIFT,XF86MonBrightnessDown,exec,brightnessctl -d ${keyboardLightID} s 1%-"
      "SHIFT,XF86MonBrightnessUp,exec,brightnessctl -d ${keyboardLightID} s 1%+"
      ",XF86AudioRaiseVolume,exec,swayosd-client --output-volume +1"
      ",XF86AudioLowerVolume,exec,swayosd-client --output-volume -1"
      "SHIFT,XF86AudioRaiseVolume,exec,swayosd-client --input-volume +1 --max-volume 255"
      "SHIFT,XF86AudioLowerVolume,exec,swayosd-client --input-volume -1 --max-volume 255"
      ",XF86MonBrightnessDown,exec,swayosd-client --brightness -2"
      ",XF86MonBrightnessUp,exec,swayosd-client --brightness +2"
    ];

    # Mouse bindings
    bindm = [
      "$modifier, mouse:272, movewindow"
      "$modifier, mouse:273, resizewindow"
    ];
  };
}