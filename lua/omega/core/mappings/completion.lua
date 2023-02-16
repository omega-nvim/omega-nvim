local map = vim.keymap.set

map("s", "<leader><tab>", function()
    require("luasnip").expand_or_jump()
end, {
    desc = "Expand snippet or jump",
})
