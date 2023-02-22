local theme = require("omega.colors.base16").themes(vim.g.colors_name)
local colors = require("omega.colors").get()

return {
    ["@function.builtin"] = { fg = theme.base0c },
    ["@field"] = { fg = colors.vibrant_green },
    ["@operator"] = { fg = "#89FFDD" },
    ["@punctuation.delimiter"] = { fg = "#89FFDD" },
    ["@conditional"] = { fg = colors.purple },
    ["TelescopeSelection"] = { fg = colors.blue, bg = colors.black2 },
    ["TelescopeSelectionCaret"] = { fg = colors.blue, bg = colors.black2 },
    ["IncSearch"] = { bg = colors.orange },
    ["IndentBlanklineChar"] = { fg = colors.orange },
}
