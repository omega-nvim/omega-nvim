return {
    { "nvim-tree/nvim-web-devicons" },
    { "rcarriga/nvim-notify" },
    { "MunifTanjim/nui.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "max397574/omega-themes", lazy = true },
    {
        "xiyaowong/nvim-colorizer.lua",
        cmd = { "ColorizerAttachToBuffer" },
        config = function()
            require("colorizer").setup({
                "*",
            }, {
                mode = "foreground",
                hsl_fn = true,
            })
            vim.cmd.ColorizerAttachToBuffer()
        end,
    },
    {
        "max397574/better-escape.nvim",
        event = { "InsertEnter" },
        config = true,
    },
    { "stevearc/oil.nvim", config = true, cmd = { "Oil" } },
}
