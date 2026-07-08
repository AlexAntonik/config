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