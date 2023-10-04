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

local function toggle_lazygit()
    require("toggleterm.terminal").Terminal:new({ cmd = "lazygit", close_on_exit = true }):toggle()
end

function toggleterm.config(_, opts)
    -- HACK: don't load utils on startup
    opts.float_opts.border = require("omega.utils").border()
    require("toggleterm").setup(opts)
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
        desc = " Run File",
    },
    {
        "<c-g>",
        mode = { "n" },
        function()
            toggle_lazygit()
        end,
        desc = " Run File",
    },
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
