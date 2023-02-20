require("omega.core.mappings.completion")
require("omega.core.mappings.insert_mode")
require("omega.core.mappings.tabline")
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
map("n", "<leader>ia", "a <esc>h", { desc = " Insert space after", noremap = true })

map("n", "<leader>p", '"0p', { desc = " Paste Last Yank", noremap = true })

map("n", "0", function()
    if vim.fn.match(vim.fn.getline(vim.fn.line(".")), [[\S]]) == (vim.fn.col(".") - 1) then
        return "0"
    else
        return "^"
    end
end, { noremap = true, expr = true, desc = "Goto Beginning of text, then line" })

map("i", " ", "<right>", { noremap = true, desc = "Move right" })

map("n", ",,", function()
    require("omega.utils").append_comma()
end, { desc = "Append comma" })

map("n", ";;", function()
    require("omega.utils").append_semicolon()
end, { desc = "Append semicolon" })

map("n", "<C-U>", function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_feedkeys("b~", "n", true)
    vim.defer_fn(function()
        vim.api.nvim_win_set_cursor(0, cursor)
    end, 1)
end, {
    desc = "Change case of word under cursor",
})

map("n", "<leader>Ls", function()
    require("lazy").sync()
end, { desc = " Lazy Sync" })
map("n", "<leader>LS", function()
    require("lazy").show()
end, { desc = " Lazy Show" })
map("n", "<leader>Lp", function()
    require("lazy").profile()
end, { desc = " Lazy Profile" })
map("n", "<leader>Li", function()
    require("lazy").install()
end, { desc = " Lazy Install" })
map("n", "<leader>Lu", function()
    require("lazy").update()
end, { desc = " Lazy Update" })
map("n", "<leader>Ll", function()
    require("lazy").log()
end, { desc = " Lazy Log" })
map("n", "<leader>Ld", function()
    require("lazy").debug()
end, { desc = " Lazy Debug" })
map("n", "<leader>Lh", function()
    require("lazy").help()
end, { desc = " Lazy Help" })

map("n", "<leader>qn", function()
    vim.cmd.cnext()
end, { desc = " Quickfix Next" })
map("n", "<leader>qn", function()
    vim.cmd.cprev()
end, { desc = " Quickfix Previous" })
map("n", "<leader>qn", function()
    vim.cmd.copen()
end, { desc = " Quickfix Open" })

map(
    "n",
    "j",
    [[(v:count > 1 ? "m'" . v:count : '') . 'j']],
    { noremap = true, expr = true, desc = "Add j with count to jumplist" }
)
map(
    "n",
    "k",
    [[(v:count > 1 ? "m'" . v:count : '') . 'k']],
    { noremap = true, expr = true, desc = "Add k with count to jumplist" }
)
