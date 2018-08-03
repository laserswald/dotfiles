require('vis')

local lazr_edit_current_dir = vis:action_register("lazr_edit_current_dir", function()
    vis:command("e .")
end, "Edit a file in the current directory")

local lazr_leader = "<Space>"

vis.events.subscribe(vis.events.INIT, function()
    vis:map(vis.modes.INSERT, "jk", "<Escape>")
    vis:map(vis.modes.NORMAL, "-", lazr_edit_current_dir)
end)

vis.events.subscribe(vis.events.WIN_OPEN, function()
    vis:command('set relativenumber on')
    vis:command('set expandtab on')
    vis:command('set autoindent on')
    vis:command('set tabwidth 4')
    vis:command('set theme default-256')
    vis:command('set syntax on')
end)
