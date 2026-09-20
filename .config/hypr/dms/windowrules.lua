-- Window rules. Deploy writes ~/.config/hypr/dms/windowrules.lua
hl.window_rule({ match = { title = "file_progress" }, float = true })
hl.window_rule({ match = { title = "confirm" }, float = true })
hl.window_rule({ match = { title = "dialog" }, float = true })
hl.window_rule({ match = { title = "download" }, float = true })
hl.window_rule({ match = { title = "notification" }, float = true })
hl.window_rule({ match = { title = "error" }, float = true })
hl.window_rule({ match = { title = "splash" }, float = true })
hl.window_rule({ match = { title = "confirmreset" }, float = true })
hl.window_rule({ match = { title = "Open File" }, float = true })
hl.window_rule({ match = { title = "branchdialog" }, float = true })
hl.window_rule({ match = { title = "Lxappearance" }, float = true })
hl.window_rule({ match = { title = "viewnior" }, float = true })
hl.window_rule({ match = { title = "feh" }, float = true })
hl.window_rule({ match = { title = "pavucontrol-qt" }, float = true })
hl.window_rule({ match = { title = "pavucontrol" }, float = true })
hl.window_rule({ match = { title = "file-roller" }, float = true })
hl.window_rule({ match = { title = "^(Media viewer)$" }, float = true })
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, float = true })
hl.window_rule({ match = { title = "Rofi" }, float = true, no_anim = true })
hl.window_rule({ match = { title = "wlogout" }, float = true, fullscreen = true })
hl.window_rule({ match = { title = "^(Alacritty)$" }, fullscreen = true })
hl.window_rule({
	match = { title = "^(Volume Control)$" },
	float = true,
	size = { 800, 600 },
	move = { "75", "44%" },
})
hl.window_rule({ match = { title = "mpv" }, idle_inhibit = "focus" })
hl.window_rule({ match = { title = "firefox" }, idle_inhibit = "fullscreen" })
hl.window_rule({
	name = "xwayland-video-bridge-fixes",
	match = { class = "xwaylandvideobridge" },
	no_initial_focus = true,
	no_focus = true,
	no_anim = true,
	no_blur = true,
	max_size = { 1, 1 },
	opacity = 0.0,
})
hl.window_rule({
	name = "ueberzugpp-image-preview",
	match = { class = "^(ueberzug.*)$" },
	float = true,
	no_anim = true,
	no_shadow = true,
	no_focus = true,
	rounding = 0,
})
