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
            char = { enabled = false },
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
