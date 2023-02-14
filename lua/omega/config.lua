local config = {}

config.ui = {
    cmdline = {
        --- "normal"|"top"|"bottom"
        position = "normal",
    },
    statusline = {},
    colorscheme = "onedark",
    telescope = {
        --- Whether to show borders or not
        --- true|false
        borders = false,
        --- How to highlight the titles
        --- "blocks"|"no_bg"
        titles = "blocks",
    },
    cmp = {},
}

return config
