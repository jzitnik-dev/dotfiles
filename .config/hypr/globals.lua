_G.SpecialApps = {
	{
		class = "Gomuks",
		exec = 'alacritty --class Gomuks -e bash -c "~/.dotfiles/bin/gomuks-wrapper"',
		bind = "SUPER + tab",
		workspace_id = "gomuks",
	},
	{
		class = "chrome-gomuks.jzitnik.dev__-Default",
		exec = 'chromium --app="https://gomuks.jzitnik.dev"',
		bind = "SUPER + semicolon",
		workspace_id = "gomuksweb",
	},
}

_G.SpecialWorkspaces = {
	{
		workspace_id = "Q",
		bind = "SUPER + CONTROL + Q",
		move_bind = "SUPER + CONTROL + SHIFT + Q",
	},
}

_G.LastSpecialWorkspace = nil

function _G.is_untouchable(win)
	if not win then
		return false
	end
	for _, app in ipairs(_G.SpecialApps) do
		if app.class == win.class then
			return true
		end
	end
	return false
end

function _G.safe(action)
	return function()
		local win = hl.get_active_window()
		if win and _G.is_untouchable(win) then
			return
		end
		hl.dispatch(action)
	end
end

for _, app in ipairs(_G.SpecialApps) do
	local full_workspace = "special:" .. app.workspace_id

	hl.window_rule({
		match = { class = app.class },
		workspace = full_workspace .. " silent",
	})

	hl.bind(app.bind, function()
		_G.LastSpecialWorkspace = full_workspace
		hl.dispatch(hl.dsp.workspace.toggle_special(app.workspace_id))
	end)
end

hl.on("hyprland.start", function()
	for _, app in ipairs(_G.SpecialApps) do
		hl.dispatch(hl.dsp.exec_cmd(app.exec))
	end
end)

hl.on("window.open", function(win)
	for _, app in ipairs(_G.SpecialApps) do
		local full_workspace = "special:" .. app.workspace_id

		if win.workspace.name == full_workspace and win.class ~= app.class then
			hl.dispatch(hl.dsp.window.move({
				window = win,
				workspace = "e+0",
				follow = false,
			}))
		end
	end
end)

for _, app in ipairs(_G.SpecialWorkspaces) do
	hl.bind(app.bind, hl.dsp.workspace.toggle_special(app.workspace_id))
	hl.bind(
		app.move_bind,
		hl.dsp.window.move({
			workspace = "special:" .. app.workspace_id,
			follow = false,
		})
	)
end

hl.bind("SUPER + r", function()
	local win = hl.get_active_window()
	local active_ws_name = nil

	if win and win.workspace then
		active_ws_name = win.workspace.name
	else
		active_ws_name = _G.LastSpecialWorkspace
	end

	if not active_ws_name then
		return
	end

	for _, app in ipairs(_G.SpecialApps) do
		local full_workspace = "special:" .. app.workspace_id

		if active_ws_name == full_workspace then
			if win and win.class == app.class then
				hl.dispatch(hl.dsp.window.close())
			else
				hl.dispatch(hl.dsp.exec_cmd(app.exec))
			end

			return
		end
	end
end)
