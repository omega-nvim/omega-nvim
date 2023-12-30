local treesitter = {
    "nvim-treesitter/nvim-treesitter",
    -- branch = "main",
    cmd = {
        "TSInstall",
        "TSBufEnable",
        "TSBufDisable",
        "TSEnable",
        "TSDisable",
        "TSModuleInfo",
    },
}

treesitter.opts = {
    highlight = { enable = true },
}

function treesitter.config(_, opts)
    require("nvim-treesitter").setup(opts)
    vim.cmd.TSBufEnable("highlight")
end

function treesitter.init()
    if not vim.tbl_contains({ "[packer]", "" }, vim.fn.expand("%")) then
        require("lazy").load({ plugins = { "nvim-treesitter" } })
    else
        vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
            callback = function()
                local file = vim.fn.expand("%")
                if not vim.tbl_contains({ "[packer]", "" }, file) then
                    require("lazy").load({ plugins = { "nvim-treesitter" } })
                end
            end,
        })
    end
end

return treesitter
