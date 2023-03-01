vim.g.colors_name = require("omega.custom.config").ui.colorscheme
require("omega.core")
local colorscheme_path = vim.fn.stdpath("cache") .. "/omega/highlights"
if not vim.loop.fs_stat(colorscheme_path) then
    require("omega.colors").compile_theme(require("omega.custom.config").ui.colorscheme)
end
loadfile(colorscheme_path)()
