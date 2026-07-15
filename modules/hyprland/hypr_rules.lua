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

local function format(list)
    return "^(" .. table.concat(list, "|") .. ")$"
end

local common_apps = {
    "[Tt]hunar",  "org.gnome.Nautilus",  "[Pp]cmanfm-qt",
    "Alacritty",  "kitty",  "kitty-dropterm",  "com.mitchellh.ghostty",  "[Gg]hostty",
    "org.telegram.desktop",  "[Dd]iscord",  "teams-for-linux","code","Code","code-oss"
}

hl.window_rule({
    match = {
        class = format(common_apps),
    },
    opacity = 0.9,
})

local settings_apps = {
    "file-roller",  "org.gnome.FileRoller",  "nm-applet",  "nm-connection-editor",
    "blueman-manager",  "nwg-displays",  "pavucontrol",  "org.pulseaudio.pavucontrol",
    "com.saivert.pwvucontrol",  "nwg-look",  "qt5ct",  "qt6ct",  "[Yy]ad","wants to save" ,
    "xdg-desktop-portal-gtk", "Add Folder to Workspace", "Media viewer", "Open Files",
}

hl.window_rule({
    match = {
        class = format(settings_apps),
    },
    float = true,
    center = true,
    opacity = 0.8,
    size = "70% 70%",
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
        title = "Picture-in-Picture",
    },
    float = true,
    opacity = "1.0 override",
    pin = true,
})

hl.window_rule({
    match = {
        class = "(codium|codium-url-handler|VSCodium|[Ss]team|[Tt]hunar)",
        title = "negative:.*codium.*|.*VSCodium.*|.*[Ss]team.*|.*[Tt]hunar.*",
    },
    float = true,
    center = true,
})

hl.window_rule({
    match = {
        initial_title = "satty",
    },
    center = true,
    float = true,
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

local specials = {
  { name = "obsidian",  cmd = "obsidian" },
  { name = "discord",   cmd = "discord" },
  { name = "telegram",  cmd = "Telegram"},
  { name = "thunar",    cmd = "thunar" },
  { name = "yazi",      cmd = "ghostty -e yazi +new-window" },
}

for _, s in ipairs(specials) do
  hl.workspace_rule({
    workspace = "special:" .. s.name,
    on_created_empty = s.cmd,
    gaps_out = 26,
    decorate = false,
  })
end