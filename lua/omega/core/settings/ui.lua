local opt = vim.opt
local g = vim.g

opt.signcolumn = "yes:3"
opt.termguicolors = true
opt.cursorline = true -- highlight current line
opt.cmdheight = 0 -- height of cmd line
opt.conceallevel = 2
opt.relativenumber = true
opt.number = true
opt.foldlevel = 100

vim.defer_fn(function()
    local base16 = require("omega.colors.themes." .. vim.g.colors_name).base16
    local colors = require("omega.colors.themes." .. vim.g.colors_name).colors
    g.terminal_color_0 = base16.base01
    g.color_base_01 = base16.base01
    g.color_base_0F = base16.base0F
    g.color_base_09 = base16.base09
    g.terminal_color_1 = base16.base08
    g.terminal_color_2 = base16.base0B
    g.terminal_color_3 = base16.base0A
    g.terminal_color_4 = base16.base0D
    g.terminal_color_5 = base16.base0E
    g.terminal_color_6 = base16.base0C
    g.terminal_color_7 = base16.base05
    g.terminal_color_8 = base16.base03
    g.terminal_color_9 = base16.base08
    g.terminal_color_10 = base16.base0B
    g.terminal_color_11 = base16.base0A
    g.terminal_color_12 = base16.base0D
    g.terminal_color_13 = base16.base0E
    g.terminal_color_14 = base16.base0C
    g.terminal_color_15 = base16.base07
    g.terminal_color_background = base16.base00
    g.terminal_color_foreground = colors.white
    opt.guicursor = "n-v-sm:block,i-c-ci-ve:ver25,r-cr-o:hor20"
    opt.showmode = false
    opt.splitkeep = "screen"
    vim.opt.fillchars = {
        eob = " ",
        vert = "║",
        horiz = "═",
        horizup = "╩",
        horizdown = "╦",
        vertleft = "╣",
        vertright = "╠",
        verthoriz = "╬",
    }
    opt.laststatus = 3
    opt.splitbelow = true
    opt.splitright = true
end, 1)
