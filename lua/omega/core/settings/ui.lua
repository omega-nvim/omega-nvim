local opt = vim.opt
local g = vim.g

opt.signcolumn = "yes:3"
opt.termguicolors = true
opt.cursorline = true -- highlight current line
opt.cmdheight = 0 -- height of cmd line
opt.conceallevel = 2
opt.relativenumber = true
opt.number = true
opt.undofile = true
opt.undodir = vim.fn.expand("~") .. "/.vim/undodir"
opt.foldlevel = 100
