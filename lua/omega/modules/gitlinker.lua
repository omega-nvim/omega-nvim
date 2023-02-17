local gitlinker = {
    "ruifm/gitlinker.nvim",
    init = function()
        vim.keymap.set("x", "<leader>gy", function()
            require("gitlinker").get_buf_range_url("v")
        end, { desc = " Git Copy Link" })
        vim.keymap.set("n", "<leader>gy", function()
            require("gitlinker").get_buf_range_url("n")
        end, { desc = " Git Copy Link" })
    end,
    config = function()
        require("gitlinker").setup({ mappings = nil })
    end,
}

return gitlinker
