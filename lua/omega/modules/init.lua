return {
    { "nvim-tree/nvim-web-devicons" },
    { "rcarriga/nvim-notify" },
    { "MunifTanjim/nui.nvim" },
    { "nvim-lua/plenary.nvim" },
    -- TODO: add to custom thing
    {
        dir = "~/neovim_plugins/colorscheme_switcher/",
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
    },
}
