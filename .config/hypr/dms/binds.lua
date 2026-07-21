-- Custom Keybinds (Hyprland 0.55+ Lua)

-- === Variables & Helpers ===
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
hl.bind("SUPER + period", hl.dsp.exec_cmd([[dms ipc call spotlight openQuery ":e "]]))
hl.bind("SUPER + SHIFT + Q", hl.dsp.exec_cmd("dms ipc call powermenu toggle"))
hl.bind("SUPER + SHIFT + A", hl.dsp.exec_cmd("dms ipc call clipboard toggle"))
hl.bind("SUPER + N", hl.dsp.exec_cmd("dms ipc call notifications toggle"))
hl.bind("SUPER + P", hl.dsp.exec_cmd("dms ipc call displayProfile open"))

-- TODO
hl.bind("SUPER + CONTROL + M", hl.dsp.exec_cmd("mounter"))
hl.bind("SUPER + CONTROL + A", hl.dsp.exec_cmd("mounter --all"))

-- === Window Management ===
hl.bind("SUPER + SHIFT + C", hl.dsp.window.close())
hl.bind("SUPER + V", hl.dsp.window.fullscreen())
hl.bind("SUPER + T", hl.dsp.window.float({ action = "toggle" }))
-- hl.bind("SUPER CONTROL + space", hl.dsp.layout("togglesplit"))

-- === Focus Navigation (VIM Keys) ===
hl.bind("SUPER + j", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + k", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + u", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + m", hl.dsp.focus({ direction = "d" }))

-- === Window Movement (VIM Keys) ===
hl.bind("SUPER + SHIFT + j", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + k", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + SHIFT + u", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + m", hl.dsp.window.move({ direction = "d" }))

-- === Resizing Windows ===
hl.bind("SUPER + CTRL + left", hl.dsp.window.resize({ x = -20, y = 0, relative = true }))
hl.bind("SUPER + CTRL + right", hl.dsp.window.resize({ x = 20, y = 0, relative = true }))
hl.bind("SUPER + CTRL + up", hl.dsp.window.resize({ x = 0, y = -20, relative = true }))
hl.bind("SUPER + CTRL + down", hl.dsp.window.resize({ x = 0, y = 20, relative = true }))

-- === Group Management ===
hl.bind("SUPER + g", hl.dsp.group.toggle())

-- === Special Workspace (Scratchpad) ===
-- hl.bind("SUPER + l", hl.dsp.focus({ workspace = "special" }))
hl.bind("SUPER + semicolon", hl.dsp.workspace.toggle_special())
hl.bind("SUPER + SHIFT + semicolon", hl.dsp.window.move({ workspace = "special", silent = true }))

-- === Workspace Navigation ===
hl.bind("SUPER + plus", hl.dsp.focus({ workspace = "1" }))
hl.bind("SUPER + ecaron", hl.dsp.focus({ workspace = "2" }))
hl.bind("SUPER + scaron", hl.dsp.focus({ workspace = "3" }))
hl.bind("SUPER + ccaron", hl.dsp.focus({ workspace = "4" }))
hl.bind("SUPER + rcaron", hl.dsp.focus({ workspace = "5" }))
hl.bind("SUPER + zcaron", hl.dsp.focus({ workspace = "6" }))
hl.bind("SUPER + yacute", hl.dsp.focus({ workspace = "7" }))
hl.bind("SUPER + aacute", hl.dsp.focus({ workspace = "8" }))
hl.bind("SUPER + iacute", hl.dsp.focus({ workspace = "9" }))
hl.bind("SUPER + eacute", hl.dsp.focus({ workspace = "10" }))
hl.bind("SUPER + right", hl.dsp.focus({ workspace = "r+1" }))
hl.bind("SUPER + left", hl.dsp.focus({ workspace = "r-1" }))

-- === Move to Workspace (Silent) ===
hl.bind("SUPER + SHIFT + plus", hl.dsp.window.move({ workspace = "1", silent = true }))
hl.bind("SUPER + SHIFT + ecaron", hl.dsp.window.move({ workspace = "2", silent = true }))
hl.bind("SUPER + SHIFT + scaron", hl.dsp.window.move({ workspace = "3", silent = true }))
hl.bind("SUPER + SHIFT + ccaron", hl.dsp.window.move({ workspace = "4", silent = true }))
hl.bind("SUPER + SHIFT + rcaron", hl.dsp.window.move({ workspace = "5", silent = true }))
hl.bind("SUPER + SHIFT + zcaron", hl.dsp.window.move({ workspace = "6", silent = true }))
hl.bind("SUPER + SHIFT + yacute", hl.dsp.window.move({ workspace = "7", silent = true }))
hl.bind("SUPER + SHIFT + aacute", hl.dsp.window.move({ workspace = "8", silent = true }))
hl.bind("SUPER + SHIFT + iacute", hl.dsp.window.move({ workspace = "9", silent = true }))
hl.bind("SUPER + SHIFT + eacute", hl.dsp.window.move({ workspace = "10", silent = true }))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.move({ workspace = "r+1", silent = true }))
hl.bind("SUPER + SHIFT + left", hl.dsp.window.move({ workspace = "r-1", silent = true }))
hl.bind("SUPER + SHIFT + e", hl.dsp.window.move({ workspace = "r+1", silent = true }))
hl.bind("SUPER + SHIFT + w", hl.dsp.window.move({ workspace = "r-1", silent = true }))

-- === Mouse Binds & Navigation ===
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- === Touchpad Gestures ===
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 2, direction = "pinch", mods = "SUPER", action = "fullscreen" })
hl.gesture({ fingers = 3, direction = "pinch", mods = "SUPER", action = "float" })
hl.gesture({ fingers = 4, direction = "down", action = "close" })
hl.gesture({ fingers = 4, direction = "horizontal", mods = "SUPER SHIFT", action = "resize" })
hl.gesture({ fingers = 4, direction = "vertical", mods = "SUPER SHIFT", action = "resize" })
hl.gesture({ fingers = 4, direction = "horizontal", mods = "SUPER", action = "move" })
hl.gesture({ fingers = 4, direction = "vertical", mods = "SUPER", action = "move" })

