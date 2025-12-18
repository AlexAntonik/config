{
  pkgs,
  env,
  ...
}:
let
  pypr = pkgs.unstable.pyprland.overrideAttrs (
    final: prev: {
      src = pkgs.fetchFromGitHub {
        owner = "hyprland-community";
        repo = "pyprland";
        rev = "ae563c23b4a0b476014ce47af8de49ec8b7ffa1f";
        hash = "sha256-nX7INrC70UDZKNY0TpsFHVph7VKyzT0KM4Mt9C96nmw=";
      };
    }
  );
in
{
  imports = [
    ./keybinds.nix
    ./windows.nix
    ./visual.nix
    ./hypridle.nix
    ./hyprpaper.nix
    ./hyprlock.nix
    ./eww/clock.nix
    ./eww/show-clock.nix
    ./wlsunset.nix
  ];
  home.packages = [
    pkgs.grim
    pkgs.slurp
    pkgs.wl-clipboard
    pypr
    pkgs.swappy
    pkgs.hyprpicker # Color picker
    pkgs.hyprpolkitagent
    pkgs.ydotool
    pkgs.unstable.hyprland-qtutils # needed for banners and ANR messages
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
        # System tray applets and agents
        "killall -q waybar; sleep 0.5 && waybar"
        "killall -q tailscale-systray; sleep 0.5 && tailscale-systray"
        "nm-applet --indicator"
        "systemctl --user start hyprpolkitagent"
        # --- Autostart applications ---
        "${env.browser}"
        # "[workspace 2 silent] code" #did not work now becouse of electron app prob fix soon
        "[workspace 3 silent] ${env.terminal} -e tmux new-session -A -s 0"
      ];
    };

    # Monitor configuration
    extraConfig = ''
      monitor=,preferred,auto,auto
      monitor=HDMI-A-1,preferred,auto,auto,transform, 3
    '';
  };

  home.file.".config/swappy/config".text = ''
    [Default]
    save_dir=/home/${env.username}/Pictures/Screenshots
    save_filename_format=swappy-%Y%m%d-%H%M%S.png
    show_panel=false
    line_size=5
    text_size=20
    text_font=Ubuntu
    paint_mode=brush
    early_exit=true
    fill_shape=false
  '';

  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = [
      "scratchpads",
    ]

    [scratchpads.term]
    animation = "fromTop"
    command = "ghostty --class=com.mitchellh.ghostty-dropterm"
    class = "com.mitchellh.ghostty-dropterm"
    unfocus = "hide"
    lazy = true
    size = "76% 70%"
    position= "12% 10%"

    [scratchpads.volume]
    animation = "fromTop"
    command = "pavucontrol"
    class = "pavucontrol"
    lazy = true
    size = "40% 90%"

    [scratchpads.yazi]
    animation = "fromBottom"
    command = "ghostty --class=com.mitchellh.ghostty-yazi -e yazi"
    class = "com.mitchellh.ghostty-yazi"
    lazy = true
    position = "2% 2%"
    size = "96% 92%"

    [scratchpads.telegram-desktop]
    animation = "fromTop"
    pinned = false
    lazy = true
    unfocus = "hide"
    # hysteresis = 10 
    command = "Telegram"
    class = "org.telegram.desktop"
    position = "2% 2%"
    size = "96% 92%"

    [scratchpads.thunar]
    animation = "fromBottom"
    command = "thunar"
    class = "thunar"
    # unfocus = "hide"
    lazy = true
    position = "12% 12%"
    size = "76% 70%"
  '';

}
