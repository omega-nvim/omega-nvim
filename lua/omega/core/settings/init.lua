local opt = vim.opt

vim.g.mapleader = " "

opt.undofile = true
opt.undodir = vim.fn.expand("~") .. "/.vim/undodir"
opt.scrolloff = 3 -- start scrolling 3 lines away from top/bottom
require("omega.core.settings.ui")
vim.defer_fn(function()
    opt.timeoutlen = 300
    opt.shiftwidth = 4
    opt.guifont = "Operator Mono Lig"
    opt.mouse = "nv"
    opt.ignorecase = true
    opt.smartcase = true
    opt.updatetime = 250
    opt.shortmess:append("c")
    opt.formatoptions = vim.opt.formatoptions
        + "r" -- continue comments after return
        + "c" -- wrap comments using textwidth
        + "q" -- allow to format comments w/ gq
        + "j" -- remove comment leader when joining lines when possible
        - "t" -- don't autoformat
        - "a" -- no autoformatting
        - "o" -- don't continue comments after o/O
        - "2" -- don't use indent of second line for rest of paragraph
    opt.jumpoptions:append("view")
    opt.virtualedit = "block" -- allow visual mode to go over end of lines
    opt.expandtab = true -- expand tabs to spaces
    opt.compatible = false
    opt.wrap = true -- wrap long lines
    opt.linebreak = true
    opt.breakindent = true
    opt.showbreak = "  ﬌"
    opt.joinspaces = false
    opt.completeopt = "menuone,noselect"
    opt.lazyredraw = false -- Do not redraw screen while processing macros
    opt.list = true --show some hidden characters
    opt.listchars = {
        tab = "> ",
        nbsp = "␣",
        trail = "•",
    }
    opt.foldmethod = "expr" -- use treesitter for folding
    opt.foldexpr = "nvim_treesitter#foldexpr()"

    opt.grepprg = "rg --vimgrep --no-heading --smart-case"
    opt.grepformat:append("%f:%l:%c:%m")
end, 1)
