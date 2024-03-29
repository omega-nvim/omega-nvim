require("omega.config").init()

return {
    { "omega-nvim/omega-nvim", config = true, lazy = false, priority = 10000, cond = true },
    { "nvim-tree/nvim-web-devicons" },
    { "rcarriga/nvim-notify" },
    { "MunifTanjim/nui.nvim" },
    { "nvim-lua/plenary.nvim" },
    {
        "max397574/omega-themes",
        lazy = false,
        priority = 100,
        config = function()
            local colorscheme_path = vim.fn.stdpath("cache") .. "/omega/highlights"
            if not vim.loop.fs_stat(colorscheme_path) then
                require("omega.colors").compile_theme(require("omega.config").colorscheme)
            end
            loadfile(colorscheme_path)()
        end,
    },
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
        branch = "feat/rewrite_with_mappings",
        event = { "InsertEnter" },
        opts = {
            mappings = {
                i = {
                    j = {
                        k = "<Esc>",
                        j = "<Esc>",
                    },
                    [" "] = {
                        ["<TAB>"] = function()
                            vim.defer_fn(function()
                                vim.o.ul = vim.o.ul
                                require("luasnip").expand_or_jump()
                            end, 1)
                        end,
                        ["<S-TAB>"] = function()
                            vim.defer_fn(function()
                                vim.o.ul = vim.o.ul
                                require("luasnip").jump(-1)
                            end, 1)
                        end,
                        [" "] = "<left>",
                    },
                },
            },
        },
    },
    { "stevearc/oil.nvim", config = true, cmd = { "Oil" } },
}
