vim.g.terminal_color_foreground = "#abb2bf"
local colors = require("omega.colors.themes.onedark").colors
return {
    ["@tag"] = { fg = colors.blue },
    ["IndentBlanklineChar"] = { fg = colors.orange },
}
