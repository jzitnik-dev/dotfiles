_G.SpecialApps = {
    {
        class = "Element",
        exec = "element-desktop",
        bind = "SUPER + tab",
        workspace_id = "element"
    },
}

function _G.is_untouchable(win)
    if not win then return false end
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
        workspace = full_workspace .. " silent"
    })

    hl.bind(app.bind, hl.dsp.workspace.toggle_special(app.workspace_id))
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
                follow = false 
            }))
        end
    end
end)
