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

local numberKeys = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "F1", "F2", "F3", "F4", "F5" }
for i, key in ipairs(numberKeys) do
  local ws = i%10 + 5*(i//10)
  hl.bind("SUPER + " .. key, focusWorkspace(ws))
  hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = ws }))
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
hl.bind("XF86WebCam", hl.dsp.exec_cmd("noctalia msg dpms-off"))
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