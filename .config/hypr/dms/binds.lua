-- Custom Keybinds (Hyprland 0.55+ Lua)

local screenshotarea = [[grimblast --notify edit area]]

-- === Wallpaper & Appearance ===
hl.bind("SUPER + comma", hl.dsp.exec_cmd("dms color pick --hex -a"))

-- === Audio & Brightness Controls ===
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("dms ipc call audio increment 5"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("dms ipc call audio decrement 5"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("dms ipc call audio mute"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("dms ipc call audio micmute"), { locked = true })

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("dms ipc call mpris playPause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("dms ipc call mpris playPause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("dms ipc call mpris next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("dms ipc call mpris previous"), { locked = true })

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd([[dms ipc call brightness decrement 5 ""]]), { repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd([[dms ipc call brightness increment 5 ""]]), { repeating = true })

-- === Screenshots ===
hl.bind("SUPER + Q", hl.dsp.exec_cmd(screenshotarea))
hl.bind("Print", hl.dsp.exec_cmd(screenshotarea))

-- === Applications & DMS UI ===
hl.bind("SUPER + F1", hl.dsp.exec_cmd("dms ipc call lock lock"))
hl.bind("SUPER + SHIFT + Return", hl.dsp.exec_cmd("alacritty"))
hl.bind("SUPER + SHIFT + F", hl.dsp.exec_cmd("thunar"))
hl.bind("SUPER + O", hl.dsp.exec_cmd("dms ipc call spotlight toggle"))
hl.bind("SUPER + SHIFT + O", hl.dsp.exec_cmd("qs ipc -c /usr/share/quickshell/dms call spotlight toggle"))
hl.bind("SUPER + period", hl.dsp.exec_cmd([[dms ipc call spotlight openQuery ":e "]]))
hl.bind("SUPER + SHIFT + Q", hl.dsp.exec_cmd("dms ipc call powermenu toggle"))
hl.bind("SUPER + SHIFT + A", hl.dsp.exec_cmd("dms ipc call clipboard toggle"))
hl.bind("SUPER + N", hl.dsp.exec_cmd("dms ipc call notifications toggle"))
hl.bind("SUPER + P", hl.dsp.exec_cmd("dms ipc call displayProfile open"))

-- TODO
hl.bind("SUPER + CONTROL + M", hl.dsp.exec_cmd("mounter"))
hl.bind("SUPER + CONTROL + A", hl.dsp.exec_cmd("mounter --all"))

-- === Window Management ===
hl.bind("SUPER + SHIFT + C", _G.safe(hl.dsp.window.close()))
hl.bind("SUPER + V", hl.dsp.window.fullscreen())
hl.bind("SUPER + T", _G.safe(hl.dsp.window.float({ action = "toggle" })))
hl.bind("SUPER + CONTROL + space", hl.dsp.layout("togglesplit"))
hl.bind("SUPER + g", hl.dsp.group.toggle())

local directions = { j = "l", k = "r", u = "u", m = "d" }
for key, dir in pairs(directions) do
    hl.bind("SUPER + " .. key, hl.dsp.focus({ direction = dir }))
    -- Wrapped Directional Moves
    hl.bind("SUPER + SHIFT + " .. key, _G.safe(hl.dsp.window.move({ direction = dir })))
end

-- === Resizing Windows (Loop) ===
local resize_steps = {
    left  = { x = -20, y = 0 },
    right = { x = 20,  y = 0 },
    up    = { x = 0,   y = -20 },
    down  = { x = 0,   y = 20 }
}
for key, step in pairs(resize_steps) do
    hl.bind("SUPER + CTRL + " .. key, _G.safe(hl.dsp.window.resize({ x = step.x, y = step.y, relative = true })))
end

local ws_keys = { "plus", "ecaron", "scaron", "ccaron", "rcaron", "zcaron", "yacute", "aacute", "iacute", "eacute" }
for i, key in ipairs(ws_keys) do
    -- SUPER + Key -> Go to Workspace
    hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = tostring(i) }))
    -- SUPER + SHIFT + Key -> Move Window to Workspace silently
    hl.bind("SUPER + SHIFT + " .. key, _G.safe(hl.dsp.window.move({ workspace = tostring(i), follow = false })))
end

-- === Relative Workspace Navigation ===
hl.bind("SUPER + right", hl.dsp.focus({ workspace = "r+1" }))
hl.bind("SUPER + left", hl.dsp.focus({ workspace = "r-1" }))
-- Wrapped Relative Moves
hl.bind("SUPER + SHIFT + right", _G.safe(hl.dsp.window.move({ workspace = "r+1", follow = false })))
hl.bind("SUPER + SHIFT + left", _G.safe(hl.dsp.window.move({ workspace = "r-1", follow = false })))
hl.bind("SUPER + SHIFT + e", _G.safe(hl.dsp.window.move({ workspace = "r+1", follow = false })))
hl.bind("SUPER + SHIFT + w", _G.safe(hl.dsp.window.move({ workspace = "r-1", follow = false })))

-- === Mouse Binds & Navigation ===
hl.bind("SUPER + mouse:272", _G.safe(hl.dsp.window.drag()), { mouse = true })
hl.bind("SUPER + mouse:273", _G.safe(hl.dsp.window.resize()), { mouse = true })
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- === Touchpad Gestures ===
hl.gesture({ fingers = 2, direction = "pinch", mods = "SUPER", action = "cursorZoom", zoom_level = 1, mode = "live" })
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "pinch", mods = "SUPER", action = "fullscreen" })
hl.gesture({ fingers = 4, direction = "down", action = "close" })
hl.gesture({ fingers = 4, direction = "horizontal", mods = "SUPER SHIFT", action = "resize" })
hl.gesture({ fingers = 4, direction = "vertical", mods = "SUPER SHIFT", action = "resize" })
hl.gesture({ fingers = 4, direction = "horizontal", mods = "SUPER", action = "move" })
hl.gesture({ fingers = 4, direction = "vertical", mods = "SUPER", action = "move" })
