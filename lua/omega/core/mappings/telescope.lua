local map = vim.keymap.set

map("n", "<leader>ff", function()
    require("telescope.builtin").find_files()
end, { desc = " Find file" })

map("n", "<leader>/", function()
    require("telescope.builtin").live_grep()
end, { desc = " Live Grep" })

map("n", "<c-s>", function()
    require("telescope.builtin").current_buffer_fuzzy_find()
end, { desc = "Current buffer fuzzy find" })
