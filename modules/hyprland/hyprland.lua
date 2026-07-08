hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.00 } } })
hl.curve("smoothOut", { type = "bezier", points = { { 0.5, 0 }, { 0.99, 0.99 } } })
hl.curve("smoothIn", { type = "bezier", points = { { 0.5, -0.5 }, { 0.68, 1.0 } } })
hl.curve("specialSlideOut", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })
hl.curve("specialSlideIn", { type = "bezier", points = { { 0.7, 0 }, { 0.84, 0 } } })
hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 4,
    bezier = "overshot",
    style = "slide",
})
hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 2,
    bezier = "smoothOut",
})
hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 2,
    bezier = "smoothOut",
})
hl.animation({
    leaf = "windowsMove",
    enabled = true,
    speed = 3,
    bezier = "smoothIn",
    style = "slide",
})
hl.animation({
    leaf = "border",
    enabled = true,
    speed = 4,
    bezier = "default",
})
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 4,
    bezier = "default",
})
hl.animation({
    leaf = "specialWorkspace",
    enabled = true,
    speed = 5,
    bezier = "specialSlideOut",
    style = "slidevert",
})

local function focusWorkspace(id)
  return function()
    local mon = hl.get_active_monitor()

    if  mon.active_special_workspace ~= nil then
      local name = mon.active_special_workspace.name:gsub("^special:", "")
      hl.dispatch(hl.dsp.workspace.toggle_special(name))
      hl.dispatch(hl.dsp.focus({ workspace = id }))
    else
      hl.dispatch(hl.dsp.focus({ workspace = id }))
    end
  end
end


hl.bind("SUPER + Return", hl.dsp.exec_cmd("ghostty +new-window"))
hl.bind("SUPER + SHIFT + Return", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
hl.bind("SUPER + GRAVE", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
hl.bind("SUPER + ESCAPE", hl.dsp.exec_cmd("noctalia msg panel-toggle session"))
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("noctalia msg panel-toggle clipboard"))
hl.bind("SUPER + W", hl.dsp.exec_cmd("firefox"))
hl.bind("SUPER + O", hl.dsp.exec_cmd("obs"))
hl.bind("SUPER + C", hl.dsp.exec_cmd("code"))
hl.bind("SUPER + G", hl.dsp.exec_cmd("gimp"))
hl.bind("SUPER + N", hl.dsp.exec_cmd("obsidian"))
hl.bind("SUPER + M", hl.dsp.exec_cmd("pavucontrol"))
hl.bind("SUPER + P", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("obsidian"))
hl.bind("SUPER + D", hl.dsp.workspace.toggle_special("discord"))
hl.bind("SUPER + E", hl.dsp.workspace.toggle_special("thunar"))
hl.bind("SUPER + T", hl.dsp.workspace.toggle_special("telegram"))
hl.bind("SUPER + Y", hl.dsp.workspace.toggle_special("yazi"))
hl.bind("SUPER + R", hl.dsp.workspace.toggle_special("term"))
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + P", hl.dsp.window.pin())
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind("SUPER + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + down", hl.dsp.window.move({ direction = "d" }))
hl.bind("SUPER + SHIFT + h", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + l", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + SHIFT + k", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + j", hl.dsp.window.move({ direction = "d" }))
hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + h", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + l", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + k", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + j", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + 1", focusWorkspace(1))
hl.bind("SUPER + 2", focusWorkspace(2))
hl.bind("SUPER + 3", focusWorkspace(3))
hl.bind("SUPER + 4", focusWorkspace(4))
hl.bind("SUPER + 5", focusWorkspace(5))
hl.bind("SUPER + 6", focusWorkspace(6))
hl.bind("SUPER + 7", focusWorkspace(7))
hl.bind("SUPER + 8", focusWorkspace(8))
hl.bind("SUPER + 9", focusWorkspace(9))
hl.bind("SUPER + 0", focusWorkspace(10))
hl.bind("SUPER + F1", focusWorkspace(6))
hl.bind("SUPER + F2", focusWorkspace(7))
hl.bind("SUPER + F3", focusWorkspace(8))
hl.bind("SUPER + F4", focusWorkspace(9))
hl.bind("SUPER + F5", focusWorkspace(10))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special" }))
hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))
hl.bind("SUPER + SHIFT + F1", hl.dsp.window.move({ workspace = 6 }))
hl.bind("SUPER + SHIFT + F2", hl.dsp.window.move({ workspace = 7 }))
hl.bind("SUPER + SHIFT + F3", hl.dsp.window.move({ workspace = 8 }))
hl.bind("SUPER + SHIFT + F4", hl.dsp.window.move({ workspace = 9 }))
hl.bind("SUPER + SHIFT + F5", hl.dsp.window.move({ workspace = 10 }))
hl.bind("SUPER + CONTROL + right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + CONTROL + left", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("ALT + Tab", hl.dsp.window.cycle_next({ next = true }))
hl.bind("ALT + Tab", hl.dsp.window.bring_to_top())
hl.bind("PRINT", hl.dsp.exec_cmd("noctalia msg screenshot-region"))
hl.bind("SUPER + PRINT", hl.dsp.exec_cmd("noctalia msg screenshot-fullscreen"))
hl.bind("SUPER + F11", hl.dsp.exec_cmd("toggle_xwayland_scale"))
hl.bind("XF86TouchpadToggle", hl.dsp.exec_cmd("toggle_touchpad"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("SUPER + SHIFT + ESCAPE", hl.dsp.exit())
hl.bind("XF86WebCam", hl.dsp.exec_cmd("toggle_display"))
hl.bind("SUPER + Z", hl.dsp.exec_cmd("notify-send -i time -a \"\" \"$(date '+%H:%M')   $(date '+%A, %d %B')\""))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("SHIFT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 1%+"), { locked = true, repeating = true })
hl.bind("SHIFT + XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 1%-"), { locked = true, repeating = true })
hl.bind("SHIFT + XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 1%-"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s +1%"), { locked = true, repeating = true })

hl.bind("SUPER + mouse:272", hl.dsp.window.drag())
hl.bind("SUPER + mouse:273", hl.dsp.window.resize())

hl.bind("SUPER + SUPER_L", hl.dsp.exec_cmd("double-click noctalia msg bar-show && sleep 0.8 && noctalia msg bar-hide"), { release = true })

hl.env("NIXOS_OZONE_WL", "1")
hl.env("NIXPKGS_ALLOW_UNFREE", "1")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})
hl.gesture({
    fingers = 3,
    direction = "up",
    action = "close",
})
hl.gesture({
    fingers = 2,
    direction = "pinchout",
    action = "resize",
})

hl.layer_rule({
  name = "noctalia",
  match = {
    namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd)$",
  },
  no_anim = true,
  ignore_alpha = 0.5,
  blur = true,
  blur_popups = true,
})

hl.window_rule({
    match = { class = "dev.noctalia.Noctalia" },
    float = true,
    size = { 1080, 920 },
})

hl.window_rule({
    match = {
        class = "([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)",
    },
    tag = "+file-manager",
})

hl.window_rule({
    match = {
        class = "(Alacritty|kitty|kitty-dropterm|com.mitchellh.ghostty|[Gg]hostty)",
    },
    tag = "+terminal",
})

hl.window_rule({
    match = {
        class = "([Dd]iscord|[Ww]ebCord|[Vv]esktop)",
    },
    tag = "+msg",
})

hl.window_rule({
    match = {
        class = "(org.telegram.desktop|io.github.tdesktop_x64.TDesktop)",
    },
    tag = "+msg",
})

hl.window_rule({
    match = {
        class = "teams-for-linux",
    },
    tag = "+msg",
})

hl.window_rule({
    match = {
        class = "gamescope",
    },
    tag = "+games",
})

hl.window_rule({
    match = {
        class = "steam_app_\\d+",
    },
    tag = "+games",
})

hl.window_rule({
    match = {
        class = "[Ss]team",
    },
    tag = "+gamestore",
})

hl.window_rule({
    match = {
        title = "[Ll]utris",
    },
    tag = "+gamestore",
})

hl.window_rule({
    match = {
        class = "com.heroicgameslauncher.hgl",
    },
    tag = "+gamestore",
})

hl.window_rule({
    match = {
        class = "(gnome-disks|wihotspot(-gui)?)",
    },
    tag = "+settings",
})

hl.window_rule({
    match = {
        class = "[Rr]ofi",
    },
    tag = "+settings",
})

hl.window_rule({
    match = {
        class = "(file-roller|org.gnome.FileRoller)",
    },
    tag = "+settings",
})

hl.window_rule({
    match = {
        class = ".blueman-manager-wrapped",
    },
    tag = "+settings",
})

hl.window_rule({
    match = {
        class = "nwg-displays",
    },
    tag = "+settings",
})

hl.window_rule({
    match = {
        class = "(nm-applet|nm-connection-editor|blueman-manager)",
    },
    tag = "+settings",
})

hl.window_rule({
    match = {
        class = "(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)",
    },
    tag = "+settings",
})

hl.window_rule({
    match = {
        class = "(nwg-look|qt5ct|qt6ct|[Yy]ad)",
    },
    tag = "+settings",
})

hl.window_rule({
    match = {
        class = "xdg-desktop-portal-gtk",
    },
    tag = "+settings",
})

hl.window_rule({
    match = {
        tag = "settings*",
    },
    float = true,
})

hl.window_rule({
    match = {
        title = "Picture-in-Picture",
    },
    float = true,
})

hl.window_rule({
    match = {
        title = "Authentication Required",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "(codium|codium-url-handler|VSCodium)",
        title = "negative:.*codium.*|.*VSCodium.*",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "com.heroicgameslauncher.hgl",
        title = "negative:Heroic Games Launcher",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "[Ss]team",
        title = "negative:[Ss]team",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "[Tt]hunar",
        title = "negative:.*[Tt]hunar.*",
    },
    float = true,
})

hl.window_rule({
    match = {
        initial_title = "Add Folder to Workspace",
    },
    float = true,
})

hl.window_rule({
    match = {
        initial_title = "Media viewer",
    },
    float = true,
})

hl.window_rule({
    match = {
        initial_title = "satty",
    },
    float = true,
})

hl.window_rule({
    match = {
        initial_title = "Open Files",
    },
    float = true,
})

hl.window_rule({
    match = {
        initial_title = "wants to save",
    },
    float = true,
})

hl.window_rule({
    match = {
        title = "Picture-in-Picture",
    },
    move = "60% 6%",
})

hl.window_rule({
    match = {
        class = "(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)",
    },
    center = true,
})

hl.window_rule({
    match = {
        initial_title = "Media viewer",
    },
    center = true,
})

hl.window_rule({
    match = {
        initial_title = "satty",
    },
    center = true,
})

hl.window_rule({
    match = {
        class = "[Tt]hunar",
        title = "negative:.*[Tt]hunar.*",
    },
    center = true,
})

hl.window_rule({
    match = {
        title = "Authentication Required",
    },
    center = true,
})

hl.window_rule({
    match = {
        initial_title = "Media viewer",
    },
    size = "86% 86%",
})

hl.window_rule({
    match = {
        initial_title = "Open Files",
    },
    size = "70% 60%",
})

hl.window_rule({
    match = {
        initial_title = "Add Folder to Workspace",
    },
    size = "70% 60%",
})

hl.window_rule({
    match = {
        tag = "settings*",
    },
    size = "70% 70%",
})

hl.window_rule({
    match = {
        class = "[Ff]erdium",
    },
    size = "60% 70%",
})

hl.window_rule({
    match = {
        tag = "msg*",
    },
    opacity = 0.86,
})

hl.window_rule({
    match = {
        tag = "file-manager*",
    },
    opacity = 0.9,
})

hl.window_rule({
    match = {
        tag = "terminal*",
    },
    opacity = 0.86,
})

hl.window_rule({
    match = {
        tag = "settings*",
    },
    opacity = 0.8,
})

hl.window_rule({
    match = {
        class = "(code|Code|code-oss)",
    },
    opacity = 0.86,
})

hl.window_rule({
    match = {
        title = "Picture-in-Picture",
    },
    opacity = "1.0 override",
    pin = true,
})

hl.window_rule({
    match = {
        tag = "games*",
    },
    no_blur = true,
    fullscreen = true,
})

hl.workspace_rule({
    workspace = "6",
    monitor = "HDMI-A-1",
    default = true,
})

hl.workspace_rule({
    workspace = "2",
    on_created_empty = "code",
})

hl.workspace_rule({
    workspace = "special:term",
    on_created_empty = "ghostty +new-window",
    gaps_out ={
        top = 70,
        right = 140,
        left = 120,
        bottom = 120,
    },
    decorate = false,
})

hl.workspace_rule({
    workspace = "special:obsidian",
    on_created_empty = "obsidian",
    gaps_out = 20,
    decorate = false,
})

hl.workspace_rule({
    workspace = "special:discord",
    on_created_empty = "discord",
    gaps_out = 20,
    decorate = false,
})

hl.workspace_rule({
    workspace = "special:telegram",
    on_created_empty = "Telegram",
    gaps_out = 26,
    decorate = false,
})

hl.workspace_rule({
    workspace = "special:thunar",
    on_created_empty = "thunar",
    gaps_out = 26,
    decorate = false,
})

hl.workspace_rule({
    workspace = "special:yazi",
    on_created_empty = "ghostty --class=com.mitchellh.ghostty-yazi -e yazi +new-window",
    gaps_out = 26,
    decorate = false,
})

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "preferred",
    position = "auto",
    scale = "auto",
    transform = 3,
})

hl.config({
    animations = {
        enabled = true,
    },
    decoration = {
        blur = {
            enabled = true,
            ignore_opacity = false,
            new_optimizations = true,
            passes = 3,
            size = 3,
        },
        shadow = {
            color = "rgba(0d0d0d99)",
            enabled = true,
            range = 4,
            render_power = 3,
        },
        dim_inactive = true,
        dim_strength = 0.160000,
        rounding = 0,
    },
    ecosystem = {
        no_donation_nag = true,
        no_update_news = false,
    },
    general = {
        border_size = 0,
        col = {
            active_border = "rgb(6b8fb8)",
            inactive_border = "rgb(4a4a4a)",
        },
        gaps_in = 0,
        gaps_out = 0,
        layout = "dwindle",
        resize_on_border = true,
    },
    group = {
        groupbar = {
            col = {
                active = "rgb(6b8fb8)",
                inactive = "rgb(4a4a4a)",
            },
            text_color = "rgb(b8b8b8)",
        },
        col = {
            border_active = "rgb(6b8fb8)",
            border_inactive = "rgb(4a4a4a)",
            border_locked_active = "rgb(6fa3a3)",
        },
    },
    input = {
        touchpad = {
            disable_while_typing = true,
            natural_scroll = true,
            scroll_factor = 0.800000,
        },
        follow_mouse = 1,
        kb_layout = "us,ru",
        kb_options = "caps:escape,grp:win_space_toggle",
        numlock_by_default = true,
        repeat_delay = 300,
        sensitivity = 0,
    },
    misc = {
        anr_missed_pings = 20,
        background_color = "rgb(0d0d0d)",
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        enable_anr_dialog = true,
        focus_on_activate = true,
        initial_workspace_tracking = 0,
        key_press_enables_dpms = false,
        layers_hog_keyboard_focus = true,
        mouse_move_enables_dpms = true,
    },
})

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd --all && systemctl --user stop hyprland-session.target && systemctl --user start hyprland-session.target")
    hl.exec_cmd("dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("firefox")
    hl.exec_cmd("ghostty", { workspace = "3 silent" })
end)

