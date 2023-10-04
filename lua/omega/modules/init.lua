return {
    { "nvim-tree/nvim-web-devicons" },
    { "rcarriga/nvim-notify" },
    { "MunifTanjim/nui.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "max397574/omega-themes", lazy = false },
    {
        "glepnir/nerdicons.nvim",
        cmd = "NerdIcons",
        opts = {},
    },
    {
        "rktjmp/paperplanes.nvim",
        cmd = { "PP" },
        config = function()
            require("paperplanes").setup({
                register = "+",
                provider = "0x0.st",
            })
        end,
    },
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
        keys = {
            {
                "<leader>vc",
                function()
                    vim.cmd.ColorizerAttachToBuffer()
                end,
                desc = " View Colors",
            },
        },
    },
    {
        "max397574/better-escape.nvim",
        event = { "InsertEnter" },
        config = true,
    },
    { "stevearc/oil.nvim", config = true, cmd = { "Oil" } },
}
