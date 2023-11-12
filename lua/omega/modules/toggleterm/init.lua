local toggleterm = {
    "akinsho/toggleterm.nvim",
    opts = {
        hide_numbers = true,
        start_in_insert = true,
        insert_mappings = true,
        shade_terminals = true,
        shading_factor = "3",
        persist_size = true,
        close_on_exit = false,
        direction = "float",
        float_opts = {
            winblend = 0,
            highlights = {
                border = "FloatBorder",
                background = "NormalFloat",
            },
        },
    },
}

function toggleterm.config(_, opts)
    -- HACK: don't load utils on startup
    opts.float_opts.border = require("omega.utils").border()
    require("toggleterm").setup(opts)
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, close_on_exit = true })

    local function toggle_lazygit()
        lazygit:toggle()
    end
    vim.keymap.set("n", "<c-g>", function()
        toggle_lazygit()
    end)
end

toggleterm.keys = {
    {
        "<leader>r",
        mode = { "n" },
        function()
            require("omega.modules.toggleterm.run_file")()
        end,
        desc = " Run File",
    },
    {
        "<c-t>",
        mode = { "n" },
        function()
            require("toggleterm.terminal").Terminal:new({ close_on_exit = true }):toggle()
        end,
        desc = "Open terminal",
    },
    "<c-g>",
    {
        "<c-g>",
        mode = { "t" },
        function()
            vim.cmd.ToggleTerm()
        end,
    },
    {
        "<c-t>",
        mode = { "t" },
        function()
            vim.cmd.ToggleTerm()
        end,
    },
}

return toggleterm
