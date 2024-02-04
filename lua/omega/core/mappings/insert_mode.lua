local map = vim.keymap.set

map("i", " ", "<right>", { desc = "Move right" })

map("i", "<C-U>", "<ESC>b~hea", { silent = true })
