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
    cmp = {
        --- What type of border to add
        --- "half"|"none"|"rounded"
        border = "half",
        --- How the icons should look
        --- "blended"|"fg_colored"
        icons = "blended",
        ---@alias CmpFields "source"|"kind_icon"|"type"|"text"
        ---@type CmpFields[]
        fields = {
            "kind_icon",
            "text",
            "type",
        },
    },
}

return config
