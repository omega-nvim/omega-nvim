local config = {}

config.ui = {
    cmdline = {
        ---@type CmdlinePosition
        position = "normal",
    },
    statusline = {},
    tabline = {
        ---@type TablineSeparatorStyle
        separator_style = "padding",
        ---@type number
        max_width = 15,
    },
    ---@type OmegaColorscheme
    colorscheme = "onedark",
    telescope = {
        --- Whether to show borders or not
        ---@type boolean
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
        ---@type CmpFields[]
        fields = {
            "kind_icon",
            "text",
            "type",
        },
    },
}

return config
