local lang_lua = {}
local function on_attach(client, bufnr)
    require("omega.modules.lsp.on_attach").setup(client, bufnr)
end

local defaults = {
    lua_ls = {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
        settings = {
            Lua = {
                diagnostics = {
                    globals = {
                        "vim",
                        "omega",
                        "hs",
                        "lvim",
                        "neorg",
                    },
                },
                completion = {
                    callSnippet = "Replace",
                    displayContext = 5,
                    showWord = "Enable",
                },
                hint = {
                    enable = true,
                    paramType = true,
                    setType = true,
                    paramName = true,
                    arrayIndex = "Enable",
                },
                hover = {
                    expandAlias = false,
                },
                type = {
                    castNumberToInteger = true,
                },
                workspace = {
                    checkThirdParty = false,
                    maxPreload = 1000,
                    preloadFileSize = 1000,
                    library = {
                        vim.fn.stdpath("config") .. "/lua/omega/types",
                        vim.fn.stdpath("config") .. "/lua",
                    },
                },
            },
        },
    },
}
defaults.neodev = {
    library = {
        runtime = true,
        types = true,
        plugins = {},
    },
    lspconfig = defaults.lua_ls,
}

function lang_lua.setup(opts)
    defaults = vim.tbl_deep_extend("force", defaults, opts.opts or {})
    require("neodev").setup(defaults.neodev)
    require("lspconfig")["lua_ls"].setup(defaults.lua_ls)
end

return lang_lua
