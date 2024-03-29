local lsp = {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    opts = {
        lua = {
            plugins = { "lazy.nvim" },
        },
    },
}

function lsp.config(_, opts)
    require("omega.modules.langs.rust")
    require("omega.modules.langs.lua").setup(opts.lua)

    vim.api.nvim_set_hl(0, "DiagnosticHeader", { link = "Special" })

    local signs = {
        Error = "",
        Warn = "",
        Info = "",
        Hint = "",
    }
    for sign, icon in pairs(signs) do
        vim.fn.sign_define("DiagnosticSign" .. sign, {
            text = icon,
            texthl = "Diagnostic" .. sign,
            numhl = "Diagnostic" .. sign,
        })
    end
    vim.diagnostic.config({
        float = {
            focusable = false,
            -- border = "rounded",
            border = require("omega.utils").border(),
            scope = "line",
            header = { "Cursor Diagnostics:", "DiagnosticHeader" },
            suffix = "",
            prefix = function(diagnostic, i, total)
                local icon, highlight
                if diagnostic.severity == 1 then
                    icon = ""
                    highlight = "DiagnosticError"
                elseif diagnostic.severity == 2 then
                    icon = ""
                    highlight = "DiagnosticWarn"
                elseif diagnostic.severity == 3 then
                    icon = ""
                    highlight = "DiagnosticInfo"
                elseif diagnostic.severity == 4 then
                    icon = ""
                    highlight = "DiagnosticHint"
                end
                return i .. "/" .. total .. " " .. icon .. "  ", highlight
            end,
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        virtual_text = false,
        severity_sort = true,
    })
end

return lsp
