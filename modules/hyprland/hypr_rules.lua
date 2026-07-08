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
    size = { 920, 720 },
})

hl.window_rule({
    match = {
        class = "([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)",
    },
    opacity = 0.9,
})

hl.window_rule({
    match = {
        class = "(Alacritty|kitty|kitty-dropterm|com.mitchellh.ghostty|[Gg]hostty)",
    },
    opacity = 0.86,
})

hl.window_rule({
    match = {
        class = "(org.telegram.desktop|[Dd]iscord|teams-for-linux|)",
    },
    opacity = 0.86,
})

hl.window_rule({
    match = {
        class = "(gamescope|steam_app_\\d+)",
    },
    no_blur = true,
    fullscreen = true,
})

hl.window_rule({
    match = {
        class = "(file-roller|org.gnome.FileRoller)",
    },
    tag = "+settings",
})

hl.window_rule({
    match = {
        class = "(nm-applet|nm-connection-editor|blueman-manager|nwg-displays)",
    },
    tag = "+settings",
})

hl.window_rule({
    match = {
        class = "(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)",
    },
    center = true,
    tag = "+settings",
})

hl.window_rule({
    match = {
        class = "(nwg-look|qt5ct|qt6ct|[Yy]ad|xdg-desktop-portal-gtk)",
    },
    tag = "+settings",
})

hl.window_rule({
    match = {
        tag = "settings*",
    },
    float = true,
    opacity = 0.8,
    size = "70% 70%",
})

hl.window_rule({
    match = {
        title = "Picture-in-Picture",
    },
    float = true,
    move = "60% 6%",
    opacity = "1.0 override",
    pin = true,
})

hl.window_rule({
    match = {
        title = "Authentication Required",
    },
    float = true,
    center = true,
})

hl.window_rule({
    match = {
        class = "(codium|codium-url-handler|VSCodium|[Ss]team|[Tt]hunar)",
        title = "negative:.*codium.*|.*VSCodium.*|*[Ss]team*|.*[Tt]hunar.*",
    },
    float = true,
    center = true,
})

hl.window_rule({
    match = {
        initial_title = "Add Folder to Workspace",
    },
    float = true,
    size = "70% 60%",
})

hl.window_rule({
    match = {
        initial_title = "Media viewer",
    },
    float = true,
    center = true,
    size = "86% 86%",
})

hl.window_rule({
    match = {
        initial_title = "satty",
    },
    center = true,
    float = true,
})

hl.window_rule({
    match = {
        initial_title = "Open Files",
    },
    float = true,
    size = "70% 60%",
})

hl.window_rule({
    match = {
        initial_title = "wants to save",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "(code|Code|code-oss)",
    },
    opacity = 0.86,
})

hl.workspace_rule({
    workspace = "6",
    monitor = "HDMI-A-1",
    default = true,
})

hl.workspace_rule({
    workspace = "1",
    on_created_empty = "firefox",
})
hl.workspace_rule({
    workspace = "2",
    on_created_empty = "code",
})
hl.workspace_rule({
    workspace = "3",
    on_created_empty = "ghostty +new-window",
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