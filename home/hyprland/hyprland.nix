{
  pkgs,
  ...
}:
{
  imports = [
    ./keybinds.nix
    ./windows.nix
    ./visual.nix
    ./hypridle.nix
    ./hyprpaper.nix
    ./hyprlock.nix
    ./wlsunset.nix
  ];
  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    hyprpicker # Color picker
    ydotool
  ];

  systemd.user.targets.hyprland-session.Unit.Wants = [
    "xdg-desktop-autostart.target"
  ];
  services.hyprpolkitagent.enable = true;
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
        "XDG_SESSION_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "GDK_BACKEND, wayland, x11" # Prefer Wayland for GTK apps, fallback to X11
        "CLUTTER_BACKEND, wayland" # Prefer Wayland for Clutter apps
        "QT_QPA_PLATFORM=wayland;xcb" # Prefer Wayland for Qt apps, fallback to XCB (X11)
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1" # Use server-side decorations for Qt Wayland apps
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1" # Auto-scaling for Qt apps
        "SDL_VIDEODRIVER, wayland,x11" # Prefer Wayland for SDL apps (Corrected from just x11)
        "EDITOR,nvim" # Default editor
        "MOZ_ENABLE_WAYLAND, 1" # Force Wayland backend for Firefox
      ];

      # Commands executed once on Hyprland startup
      exec-once = [
        "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "vicinae server"
        # System tray applets and agents
        "killall -q noctalia-shell; sleep 0.2 && noctalia-shell"
        "killall -q tailscale-systray; sleep 0.5 && tailscale-systray"
        "nm-applet --indicator"
        # --- Autostart applications ---
        "firefox"
        "[workspace 3 silent] ghostty"
      ];
    };

    # Monitor configuration
    extraConfig = ''
      monitor=,preferred,auto,auto
      monitor=HDMI-A-1,preferred,auto,auto,transform, 3
    '';
  };
}
