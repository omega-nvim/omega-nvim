local heirline = {
    "rebelot/heirline.nvim",
    lazy = false,
}

function heirline.config()
    local config = require("omega.custom.config")
    local theme = require("omega.colors.themes." .. vim.g.colors_name)
    local conditions = require("heirline.conditions")
    local components = require("omega.modules.heirline.components")
    local align = { provider = "%=" }
    local empty = { provider = "" }

    local space = setmetatable({ provider = " " }, {
        __call = function(_, n)
            return { provider = string.rep(" ", n) }
        end,
    })

    require("heirline").setup({
        statusline = {
            components.mode_indicator,
            space(3),
            components.current_dir,
            space(2),
            components.file_name,
            align,
            components.diagnostics,
            components.lsp_progress,
            align,
            components.coords,
            space(2),
            components.progress_bar,
            space(3),
            components.word_count,
        },
    })
end

return heirline
