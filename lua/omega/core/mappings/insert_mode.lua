local map = vim.keymap.set

map("i", " ", "<right>", { desc = "Move right" })

map("i", "<C-U>", "<ESC>b~hea", { silent = true })

vim.api.nvim_create_autocmd("InsertCharPre", {
    callback = function()
        if vim.v.char == " " then
            vim.keymap.set("i", "<tab>", function()
                pcall(vim.keymap.del, "i", "<tab>")
                vim.api.nvim_input("<bs>")
                vim.defer_fn(function()
                    vim.o.ul = vim.o.ul
                    require("luasnip").expand_or_jump()
                end, 1)
            end)
            vim.defer_fn(function()
                pcall(vim.keymap.del, "i", "<tab>")
            end, vim.o.timeoutlen)
            vim.keymap.set("i", "<s-tab>", function()
                pcall(vim.keymap.del, "i", "<s-tab>")
                vim.api.nvim_input("<bs>")
                vim.defer_fn(function()
                    require("luasnip").jump(-1)
                end, 1)
            end)
            vim.defer_fn(function()
                pcall(vim.keymap.del, "i", "<s-tab>")
            end, vim.o.timeoutlen)
            vim.keymap.set("i", " ", function()
                pcall(vim.keymap.del, "i", " ")
                vim.api.nvim_input("<bs><left>")
            end)
            vim.defer_fn(function()
                pcall(vim.keymap.del, "i", " ")
            end, vim.o.timeoutlen)
        else
            pcall(vim.keymap.del, "i", " ")
            pcall(vim.keymap.del, "i", "<tab>")
        end
    end,
})
