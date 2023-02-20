local surround = {
    "kylechui/nvim-surround",
    keys = { "ys", "ds", "cs" },
    init = function()
        vim.keymap.set("v", "S", function()
            require("nvim-surround").visual_surround()
        end, {})
    end,
}

surround.opts = {
    surrounds = {
        ["\\"] = {
            add = function()
                local input = get_input("Enter environment name: ")
                if input then
                    local aliases = {
                        ["bold"] = "textbf",
                        ["italic"] = "textit",
                    }
                    input = aliases[input] or input
                    return { { "\\" .. input .. "{" }, { "}" } }
                end
            end,
        },
    },
    highlight = {
        duration = 300,
    },
    move_cursor = false,
}

local get_input = function(prompt)
    local ok, result = pcall(vim.fn.input, { prompt = prompt })
    if not ok then
        return nil
    end
    return result
end

surround.config = function(_, opts)
    require("nvim-surround").setup(opts)
    vim.api.nvim_set_hl(0, "NvimSurroundHighlight", { link = "CurSearch" })
end

return surround
