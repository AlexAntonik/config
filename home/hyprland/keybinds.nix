{
  host,
  ...
}:
let
  inherit (import ../../hosts/${host}/env.nix)
    browser
    terminal
    keyboardLayout
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

    # Input device settings
    input = {
      kb_layout = "${keyboardLayout}";
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

    # Repeatable actions
    bindle = [
      "SHIFT,XF86MonBrightnessDown,exec,brightnessctl -d ${keyboardLightID} s 1%-"
      "SHIFT,XF86MonBrightnessUp,exec,brightnessctl -d ${keyboardLightID} s 1%+"
      ",XF86AudioRaiseVolume,exec,swayosd-client --output-volume +1"
      ",XF86AudioLowerVolume,exec,swayosd-client --output-volume -1"
      ",XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
      "SHIFT,XF86AudioRaiseVolume,exec,swayosd-client --input-volume +1 --max-volume 255"
      "SHIFT,XF86AudioLowerVolume,exec,swayosd-client --input-volume -1 --max-volume 255"
      ",XF86MonBrightnessDown,exec,swayosd-client --brightness -2"
      ",XF86MonBrightnessUp,exec,swayosd-client --brightness +2"
    ];

    # Mouse bindings
    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];

    # Keybindings
    bind = [

      # --- Application Launchers ---
      "SUPER,Return,exec,${terminal}" # Launch terminal
      "SUPER SHIFT,Return,exec,rofi-launcher" # Launch Rofi application launcher
      "SUPER ,GRAVE,exec,rofi-launcher" # Launch Rofi application launcher
      "SUPER ALT,W,exec,wallsetter" # Custom wallpaper setter script
      "SUPER,W,exec,${browser}" # Launch browser
      "SUPER SHIFT,E,exec,emopicker9000" # Emoji picker
      "SUPER,D,exec,discord" # Launch Discord
      "SUPER,O,exec,obs" # Launch OBS Studio
      "SUPER,C,exec,code" # Launch VS Code
      "SUPER SHIFT,C,exec,rofi -show calc -modi calc -no-show-match -no-sort" # Emoji picker
      "SUPER,G,exec,gimp" # Launch GIMP
      "SUPER,N,exec,obsidian" # Launch Obsidian
      "SUPER,M,exec,pavucontrol" # Launch Pavucontrol
      "SUPER,V,exec,clipboard-manager" # clipboard mgr
      "SUPER,P,exec,hyprpicker -a" # Color picker
      "SUPER,E,exec,pypr toggle thunar" # Toggle Thunar file manager
      "SUPER,T,exec,pypr toggle telegram-desktop" # Toggle Telegram
      "SUPER,R,exec,pypr toggle term" # Toggle terminal
      "SUPER,Y,exec,pypr toggle yazi" # Toggle Yazi

      # --- Window Management ---
      "SUPER,Q,killactive," # Close active window
      "SUPER SHIFT,P,pin," # Pin window
      "SUPER SHIFT,I,togglesplit," # Toggle split
      "SUPER,F,fullscreen," # Toggle fullscreen
      "SUPER SHIFT,F,togglefloating," # Toggle floating
      "SUPER ALT,F,workspaceopt, allfloat" # Toggle all floating

      # --- Window Movement ---
      "SUPER SHIFT,left,movewindow,l"
      "SUPER SHIFT,right,movewindow,r"
      "SUPER SHIFT,up,movewindow,u"
      "SUPER SHIFT,down,movewindow,d"
      "SUPER SHIFT,h,movewindow,l"
      "SUPER SHIFT,l,movewindow,r"
      "SUPER SHIFT,k,movewindow,u"
      "SUPER SHIFT,j,movewindow,d"

      # --- Focus Movement ---
      "SUPER,left,movefocus,l"
      "SUPER,right,movefocus,r"
      "SUPER,up,movefocus,u"
      "SUPER,down,movefocus,d"
      "SUPER,h,movefocus,l"
      "SUPER,l,movefocus,r"
      "SUPER,k,movefocus,u"
      "SUPER,j,movefocus,d"

      # --- Workspace Management ---
      "SUPER,1,workspace,1"
      "SUPER,2,workspace,2"
      "SUPER,3,workspace,3"
      "SUPER,4,workspace,4"
      "SUPER,5,workspace,5"
      "SUPER,6,workspace,6"
      "SUPER,7,workspace,7"
      "SUPER,8,workspace,8"
      "SUPER,9,workspace,9"
      "SUPER,0,workspace,10"
      "SUPER,F1,workspace,6"
      "SUPER,F2,workspace,7"
      "SUPER,F3,workspace,8"
      "SUPER,F4,workspace,9"
      "SUPER,F5,workspace,10"
      "SUPER,S,togglespecialworkspace"

      # --- Move to Workspace ---
      "SUPER SHIFT,S,movetoworkspace,special"
      "SUPER SHIFT,1,movetoworkspace,1"
      "SUPER SHIFT,2,movetoworkspace,2"
      "SUPER SHIFT,3,movetoworkspace,3"
      "SUPER SHIFT,4,movetoworkspace,4"
      "SUPER SHIFT,5,movetoworkspace,5"
      "SUPER SHIFT,6,movetoworkspace,6"
      "SUPER SHIFT,7,movetoworkspace,7"
      "SUPER SHIFT,8,movetoworkspace,8"
      "SUPER SHIFT,9,movetoworkspace,9"
      "SUPER SHIFT,0,movetoworkspace,10"
      "SUPER SHIFT,F1,movetoworkspace,6"
      "SUPER SHIFT,F2,movetoworkspace,7"
      "SUPER SHIFT,F3,movetoworkspace,8"
      "SUPER SHIFT,F4,movetoworkspace,9"
      "SUPER SHIFT,F5,movetoworkspace,10"

      # --- Workspace Navigation ---
      "SUPER CONTROL,right,workspace,e+1"
      "SUPER CONTROL,left,workspace,e-1"
      "SUPER,mouse_down,workspace, e+1"
      "SUPER,mouse_up,workspace, e-1"
      "ALT,Tab,cyclenext,"
      "ALT,Tab,bringactivetotop,"

      # --- System Controls ---
      ",PRINT,exec,screenshootin"
      "SUPER, F11,exec,toggle_xwayland_scale"
      "SUPER, PRINT,exec,grim - | swappy -f -"
      "SUPER SHIFT,N,exec,swaync-client -rs"
      ",XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"
      ",XF86TouchpadToggle , exec, toggle_touchpad"
      ",XF86AudioPlay, exec, playerctl play-pause"
      ",XF86AudioPause, exec, playerctl play-pause"
      ",XF86AudioNext, exec, playerctl next"
      ",XF86AudioPrev, exec, playerctl previous"
      "SUPER SHIFT,ESCAPE,exit,"
      "SUPER,ESCAPE,exec,wlogout"
      ",XF86WebCam,exec,toggle_display"
      # Waybar toggle
      "ALT,SPACE, exec, pkill -SIGUSR1 waybar"

      # Workaround to change vertical tabs keybind in firefox
      "ALT,Z,exec,hyprctl activewindow -j | jq -r '.class' | grep -q firefox && wtype -M ctrl -M alt -k z"

      # Hack to display curren lang in swayosd !!!kb layout change here!!!
      "SUPER,SPACE,exec,sleep 0.1 && swayosd-client --custom-message=\"$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap')\" --custom-icon=input-keyboard"
    ];
    #Changing kb layout
    input.kb_options = "caps:escape,grp:win_space_toggle";
    # also need to be changed here in binds up some lines
    # and in sevices.xserver.xkb in separate file services.nix
  };
}
