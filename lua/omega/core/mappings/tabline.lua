local map = vim.keymap.set
map("n", "<leader>bn", function()
    require("omega.modules.ui.tabline").next_buf()
end, { desc = "﩯Buffer Next" })

map("n", "<leader>bp", function()
    require("omega.modules.ui.tabline").prev_buf()
end, { desc = "﩯Buffer Previous" })

map("n", "<leader>bd", function()
    require("omega.modules.ui.tabline").close_buf(0)
end, { desc = "﩯Buffer Close" })

map("n", "<leader>tN", function()
    vim.cmd.tabnew()
end, { desc = "  Tab New" })

map("n", "<leader>tr", function()
    require("omega.modules.ui.tabline").rename_tab()
end, { desc = "  Tab Rename" })

map("n", "<leader>tn", function()
    vim.cmd.tabnext()
end, { desc = "  Tab Next" })

map("n", "<leader>tp", function()
    vim.cmd.tabprevious()
end, { desc = "  Tab Previous" })

map("n", "<leader>td", function()
    require("omega.modules.ui.tabline").close_tab()
end, { desc = "  Tab Close" })
