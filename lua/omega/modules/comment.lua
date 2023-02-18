local comment = {
    "numToStr/Comment.nvim",
    keys = { "<leader>c", "gb", { "<leader>c", mode = "x" } },
    opts = {
        toggler = {
            line = "<leader>cc",
            block = "gbc",
        },

        opleader = {
            line = "<leader>c",
            block = "gb",
        },
    },
}

return comment
