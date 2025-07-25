{
  pkgs,
  username,
  host,
  ...
}:
let
  inherit (import ../../hosts/${host}/variables.nix)
    extraMonitorSettings
    browser
    terminal
    ;
in
{
  home.packages = with pkgs; [
    swww
    grim
    slurp
    wl-clipboard
    swappy
    hyprpicker # Color picker
    hyprpolkitagent
    ydotool
    unstable.hyprland-qtutils # needed for banners and ANR messages
  ];

  systemd.user.targets.hyprland-session.Unit.Wants = [
    "xdg-desktop-autostart.target"
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    systemd = {
      enable = true;
      enableXdgAutostart = true;
      variables = [ "--all" ];
    };

    xwayland = {
      enable = true;
      # hidpi = true;
    };
    # enableNvidiaPatches = false;

    settings = {

      ecosystem = {
        no_donation_nag = true;
        no_update_news = false;
      };

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
        #"AQ_DRM_DEVICES,/dev/dri/card0:/dev/dri/card1:/dev/card2" # Example for multi-GPU setups (adjust if needed)
        # Explicit scaling factors (might override auto-scaling, use with caution)
        "GDK_SCALE,1"
        "QT_SCALE_FACTOR,1"
        "WINIT_X11_SCALE_FACTOR,1"
        "QT_AUTO_SCREEN_SCALE_FACTOR,0" # Disable auto screen scale factor if setting manually
        "QT_SCREEN_SCALE_FACTORS,1" # Manual screen scale factor for Qt
      ];

      # Commands executed once on Hyprland startup
      exec-once = [
        "wl-paste --type text --watch cliphist store" # Stores only text data
        "wl-paste --type image --watch cliphist store" # Stores only image data
        "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "killall -q swww; sleep 0.5 && swww init"
        "killall -q waybar; sleep 0.5 && waybar"
        "killall -q swaync; sleep 0.5 && swaync"
        # "oneshot" # dotfiles set and some configs
        # System tray applets and agents
        "nm-applet --indicator"
        "systemctl --user start hyprpolkitagent"
        # Set wallpaper (delay allows swww to initialize)
        "sleep 1.5 && swww img /home/${username}/Pictures/Wallpapers/mountains.jpg"
        # --- Autostart applications ---
        "pypr &"
        "${browser}"
        "protonvpn-app"
        # "[workspace 2 silent] code" #did not work now becouse of electron app prob fix soon
        "[workspace 3 silent] ${terminal}"
        "[workspace special silent] obsidian"
      ];
    };

    # Monitor configuration
    extraConfig = ''
      monitor=,preferred,auto,auto
      ${extraMonitorSettings}
    '';
  };

  # Place Files Inside Home Directory
  home.file."Pictures/Wallpapers" = {
    source = ../wallpapers;
    recursive = true;
  };

  home.file.".config/swappy/config".text = ''
    [Default]
    save_dir=/home/${username}/Pictures/Screenshots
    save_filename_format=swappy-%Y%m%d-%H%M%S.png
    show_panel=false
    line_size=5
    text_size=20
    text_font=Ubuntu
    paint_mode=brush
    early_exit=true
    fill_shape=false
  '';
}
