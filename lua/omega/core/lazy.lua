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

local settings = vim.tbl_deep_extend("force", {
    defaults = {
        lazy = true,
    },
    install = {
        colorscheme = { require("omega.custom.config").ui.colorscheme },
    },
    ui = {
        custom_keys = {
            ["<leader>?"] = function(plugin)
                vim.pretty_print(plugin)
            end,
        },
    },
    diff = {
        cmd = "git",
    },
    change_detection = {
        notify = false,
    },
    profiling = {
        loader = true,
        require = true,
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

settings.spec = {
    { import = "omega.modules" },
    { import = "omega.custom.modules" },
}

require("lazy").setup(settings)
