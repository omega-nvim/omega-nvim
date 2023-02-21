vim.api.nvim_create_user_command("NewTheme", function(args)
    require("omega.colors").new_theme(args.fargs[1])
end, {
    desc = "New theme",
    nargs = 1,
    complete = function()
        return require("omega.utils").get_themes()
    end,
})

vim.api.nvim_create_user_command("ViewColors", function()
    require("omega.colors.extras.color_viewer").view_colors()
end, { desc = "View Colors", nargs = 0 })

vim.api.nvim_create_user_command("ViewHighlights", function()
    require("omega.colors.extras.highlight_viewer")()
end, { desc = "View Highlights", nargs = 0 })
