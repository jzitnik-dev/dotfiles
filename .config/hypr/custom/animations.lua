--[[hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.animation({ leaf = "windows", enabled = true, speed = 2, bezier = "easeOutQuint", style = "popin 80%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "easeOutQuint", style = "popin 80%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 2, bezier = "easeOutQuint" })
hl.animation({ leaf = "border", enabled = true, speed = 3, bezier = "easeOutQuint" })
hl.animation({ leaf = "fade", enabled = true, speed = 2, bezier = "easeOutQuint" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 2, bezier = "easeOutQuint" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 1, bezier = "easeOutQuint", style = "slidefadevert 20%" })]]--

hl.animation({ leaf = "global", enabled = false })
