local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup(
    "omega.modules",
    vim.tbl_deep_extend("force", {
        defaults = {
            lazy = true,
        },
        ui = {
            icons = {
                lazy = "鈴",
            },
        },
        diff = {
            cmd = "git",
        },
        performance = {
            rtp = {
                paths = {
                    vim.fn.expand("~") .. "/.config/nvim",
                },
                disabled_plugins = {
                    "loaded_python3_provider",
                    "python_provider",
                    "node_provider",
                    "ruby_provider",
                    "perl_provider",
                    "2html_plugin",
                    "getscript",
                    "getscriptPlugin",
                    "gzip",
                    "tar",
                    "tarPlugin",
                    "rrhelper",
                    "vimball",
                    "vimballPlugin",
                    "zip",
                    "zipPlugin",
                    "tutor",
                    "rplugin",
                    "logiPat",
                    "netrwSettings",
                    "netrwFileHandlers",
                    "syntax",
                    "synmenu",
                    "optwin",
                    "compiler",
                    "bugreport",
                    "ftplugin",
                    "load_ftplugin",
                    "indent_on",
                    "netrwPlugin",
                    "tohtml",
                    "man",
                },
            },
        },
    }, require("omega.custom.config.lazy"))
)
