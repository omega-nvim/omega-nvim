vim.loader.enable()
local colorscheme_path = vim.fn.stdpath("cache") .. "/omega/highlights"
if not vim.loop.fs_stat(colorscheme_path) then
    require("omega.core")
    require("omega.colors").compile_theme(require("omega.custom.config").ui.colorscheme)
end
loadfile(colorscheme_path)()
require("omega.core")
