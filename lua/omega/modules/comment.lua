local comment = {
    "numToStr/Comment.nvim",
    keys = { "<leader>c", "gb", { "<leader>c", mode = "x" } },
}

comment.config = function()
    require("Comment").setup({
        toggler = {
            line = "<leader>cc",
            block = "gbc",
        },

        opleader = {
            line = "<leader>c",
            block = "gb",
        },
    })
end

return comment
