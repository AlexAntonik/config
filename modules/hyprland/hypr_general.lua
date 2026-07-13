hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)
hl.env("NIXOS_OZONE_WL", "1")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")

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

hl.config({
    animations = {
        enabled = true,
    },
    decoration = {
        blur = {
            enabled = true,
            ignore_opacity = false,
            new_optimizations = true,
            passes = 2,
            size = 5,
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


