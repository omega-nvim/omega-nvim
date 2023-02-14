require("omega.core.mappings.telescope")

local map = vim.keymap.set

map({ "v", "n" }, "<leader>y", '"+y', { noremap = true, silent = true, desc = " Yank to clipboard" })

map("n", "<esc>", function()
    require("notify").dismiss()
    vim.cmd.nohl()
end, { noremap = true, silent = true, desc = "Clear highlight from search and close notifications" })

map("n", "zg", function()
    if vim.bo.spelllang == "en" then
        vim.bo.spellfile = vim.fn.expand("~") .. "/.config/nvim/spell/en.utf-8.add"
    elseif vim.bo.spelllang == "de" then
        vim.bo.spellfile = vim.fn.expand("~") .. "/.config/nvim/spell/de.utf-8.add"
    else
        vim.bo.spellfile = vim.fn.expand("~") .. "/.config/nvim/spell/en.utf-8.add"
    end
    vim.cmd.normal({ args = { "zg" }, bang = true })
end, { desc = "Fix spellfiles with lazy.nvim" })

map("n", "<leader>W", function()
    vim.cmd.w()
end, { desc = " Write" })

map("n", "<leader>S", function()
    vim.cmd.Format()
end, { desc = " Format" })

map("n", "<c-l>", "<c-w>l", { noremap = true, desc = "Move to right window" })
map("n", "<c-h>", "<c-w>h", { noremap = true, desc = "Move to left window" })
map("n", "<c-k>", "<c-w>k", { noremap = true, desc = "Move to above window" })
map("n", "<c-j>", "<c-w>j", { noremap = true, desc = "Move to below window" })

map("n", "<leader>io", function()
    local lines = {}
    for _ = 1, math.max(vim.v.count, 1) do
        table.insert(lines, "")
    end
    vim.api.nvim_buf_set_lines(0, vim.api.nvim_win_get_cursor(0)[1], vim.api.nvim_win_get_cursor(0)[1], false, lines)
end, { desc = " Insert empty line below" })

map("n", "<leader>iO", function()
    local lines = {}
    for _ = 1, math.max(vim.v.count, 1) do
        table.insert(lines, "")
    end
    vim.api.nvim_buf_set_lines(
        0,
        vim.api.nvim_win_get_cursor(0)[1] - 1,
        vim.api.nvim_win_get_cursor(0)[1] - 1,
        false,
        lines
    )
end, { desc = " Insert empty line above" })

map("n", "<leader>ii", "i <esc>l", { desc = " Insert space before", noremap = true })
map("n", "<leader>ia", "i <esc>l", { desc = " Insert space after", noremap = true })

map("i", " ", "<right>", { noremap = true, desc = "Move right" })
