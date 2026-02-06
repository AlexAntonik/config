{
  env,
  pkgs,
  ...
}: let
  toggleoffspecial = pkgs.writeShellScript "toggleoffspecial" ''
    ${pkgs.hyprland}/bin/hyprctl monitors -j | ${pkgs.jq}/bin/jq -r '.[] | select(.focused == true) | .specialWorkspace.name' | sed 's/special://' | xargs -I [] ${pkgs.hyprland}/bin/hyprctl dispatch togglespecialworkspace []
  '';
in {
  wayland.windowManager.hyprland.settings = {
    # Gesture settings (for touchpads/touchscreens)
    gesture = [
      "3, horizontal, workspace"
      "3, up, close"
      "2, pinchout, resize"
      "2, pinchout, mod: SUPER, move"
    ];

    # Input device settings
    input = {
      kb_layout = "${env.keyboardLayout}";
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
      "SHIFT,XF86MonBrightnessDown,exec,brightnessctl -d ${env.keyboardLightID} s 1%-"
      "SHIFT,XF86MonBrightnessUp,exec,brightnessctl -d ${env.keyboardLightID} s 1%+"
      ",XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"
      ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      "SHIFT,XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 1%+"
      "SHIFT,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 1%-"
      "SHIFT,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86MonBrightnessDown,exec,brightnessctl s 2-"
      ",XF86MonBrightnessUp,exec,brightnessctl s 2+"
    ];

    # Mouse bindings
    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];

    bind = [
      # --- Application Launchers ---
      "SUPER,Return,exec,ghostty +new-window" # Launch terminal
      "SUPER SHIFT,Return,exec,vicinae toggle"
      "SUPER ,GRAVE,exec,vicinae toggle"
      "SUPER ,ESCAPE,exec,noctalia-shell ipc call sessionMenu toggle"
      "SUPER,W,exec,firefox" # Launch browser
      "SUPER,O,exec,obs" # Launch OBS Studio
      "SUPER,C,exec,code" # Launch VS Code
      "SUPER,G,exec,gimp" # Launch GIMP
      "SUPER,N,exec,obsidian" # Launch Obsidian
      "SUPER,M,exec,pavucontrol" # Launch Pavucontrol
      "SUPER,P,exec,hyprpicker -a" # Color picker
      "SUPER,S,togglespecialworkspace, obsidian"
      "SUPER,D,togglespecialworkspace, discord" # Togglez Discord
      "SUPER,E,togglespecialworkspace, thunar" # Toggle Thunar file manager
      "SUPER,T,togglespecialworkspace, telegram" # Toggle Telegram
      "SUPER,Y,togglespecialworkspace, yazi" # Toggle Yazi
      "SUPER,R,togglespecialworkspace, term" # Toggle terminal

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
      "SUPER,1,exec,${toggleoffspecial}"
      "SUPER,2,workspace,2"
      "SUPER,2,exec,${toggleoffspecial}"
      "SUPER,3,workspace,3"
      "SUPER,3,exec,${toggleoffspecial}"
      "SUPER,4,workspace,4"
      "SUPER,4,exec,${toggleoffspecial}"
      "SUPER,5,workspace,5"
      "SUPER,5,exec,${toggleoffspecial}"
      "SUPER,6,workspace,6"
      "SUPER,6,exec,${toggleoffspecial}"
      "SUPER,7,workspace,7"
      "SUPER,7,exec,${toggleoffspecial}"
      "SUPER,8,workspace,8"
      "SUPER,8,exec,${toggleoffspecial}"
      "SUPER,9,workspace,9"
      "SUPER,9,exec,${toggleoffspecial}"
      "SUPER,0,workspace,10"
      "SUPER,0,exec,${toggleoffspecial}"
      "SUPER,F1,workspace,6"
      "SUPER,F1,exec,${toggleoffspecial}"
      "SUPER,F2,workspace,7"
      "SUPER,F2,exec,${toggleoffspecial}"
      "SUPER,F3,workspace,8"
      "SUPER,F3,exec,${toggleoffspecial}"
      "SUPER,F4,workspace,9"
      "SUPER,F4,exec,${toggleoffspecial}"
      "SUPER,F5,workspace,10"
      "SUPER,F5,exec,${toggleoffspecial}"

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
      ",PRINT,exec,screenshot"
      "SUPER, F11,exec,toggle_xwayland_scale"
      ",XF86TouchpadToggle , exec, toggle_touchpad"
      ",XF86AudioPlay, exec, playerctl play-pause"
      ",XF86AudioPause, exec, playerctl play-pause"
      ",XF86AudioNext, exec, playerctl next"
      ",XF86AudioPrev, exec, playerctl previous"
      "SUPER SHIFT,ESCAPE,exit,"
      ",XF86WebCam,exec,toggle_display"

      # Show temporary clock overlay
      "SUPER,Z,exec,show-clock"
    ];
    #Changing kb layout
    input.kb_options = "caps:escape,grp:win_space_toggle";
    # also need to be changed here in binds up some lines
    # and in sevices.xserver.xkb in separate file services.nix
  };
}
