local flash = {
    "folke/flash.nvim",
    opts = {
        char = {
            keys = { "f", "F", ";", "," },
        },
        jump = {
            autojump = true,
        },
        modes = {
            search = {
                search = {
                    incremental = true,
                    trigger = ";",
                },
            },
        },
        label = {
            current = true,
            before = true,
            after = false,
        },
        prompt = {
            prefix = { { " ", "FlashPromptIcon" } },
        },
    },
}

function flash.config(_, opts)
    require("flash").setup(opts)
    -- vim.keymap.del("o", "f")
    -- vim.keymap.del("o", "F")
    -- vim.keymap.del("o", ";");
    -- vim.keymap.del("o", ",")
end

vim.keymap.set("o", "r", function()
    require("flash").remote()
end)

flash.keys = {
    "/",
    {
        "s",
        mode = { "n", "x", "o" },
        function()
            require("flash").jump()
        end,
    },
    {
        "*",
        mode = { "n" },
        function()
            require("flash").jump({
                pattern = vim.fn.expand("<cword>"),
            })
        end,
    },
    {
        "S",
        mode = { "o", "x" },
        function()
            require("flash").treesitter()
        end,
    },
    {
        "R",
        mode = { "o", "x" },
        function()
            require("flash").treesitter_search()
        end,
    },
}

return flash
