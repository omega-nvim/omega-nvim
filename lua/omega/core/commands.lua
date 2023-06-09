vim.api.nvim_create_user_command("NewTheme", function(args)
    require("omega.colors").new_theme(args.fargs[1])
end, {
    desc = "New theme",
    nargs = 1,
    complete = function(_, cmd_text)
        local themes = require("omega.utils").get_themes()
        local cmdline = vim.api.nvim_parse_cmd(cmd_text, {})
        if #cmdline.args == 0 then
            return themes
        elseif #cmdline.args == 1 then
            if not vim.tbl_contains(themes, cmdline.args[1]) then
                local completions = {}
                for _, theme in ipairs(themes) do
                    if vim.startswith(theme, cmdline.args[1]) then
                        table.insert(completions, theme)
                    end
                end
                return completions
            end
            return {}
        end
    end,
})

vim.api.nvim_create_user_command("ViewColors", function()
    require("omega.colors.extras.color_viewer").view_colors()
end, { desc = "View Colors", nargs = 0 })

vim.api.nvim_create_user_command("ViewHighlights", function()
    require("omega.colors.extras.highlight_viewer")()
end, { desc = "View Highlights", nargs = 0 })

vim.api.nvim_create_user_command("ViewNorgSpec", function()
    if vim.loop.fs_stat("./specs.norg") then
        vim.fn.delete("./specs.norg")
    end
    vim.fn.system({
        "curl",
        "https://raw.githubusercontent.com/nvim-neorg/norg-specs/main/1.0-specification.norg",
        "-o",
        "./specs.norg",
    })
    vim.cmd.e("./specs.norg")
    vim.keymap.set("n", "q", function()
        vim.cmd.bdelete()
        if vim.loop.fs_stat("./specs.norg") then
            vim.fn.delete("./specs.norg")
        end
    end, { buffer = true })
end, { desc = "View Norg Specification" })
