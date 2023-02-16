local lua_cmd = {
    vim.fn.expand("~") .. "/lua-language-server/bin/lua-language-server",
}
local function on_attach(client, bufnr)
    require("omega.modules.lsp.on_attach").setup(client, bufnr)
end

local sumneko_lua_server = {
    on_attach = on_attach,
    cmd = lua_cmd,
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
            },
        },
    },
}

require("neodev").setup({
    library = {
        vimruntime = true,
        types = true,
        plugins = {},
    },
    runtime_path = true,
    lspconfig = sumneko_lua_server,
})
require("lspconfig")["lua_ls"].setup(sumneko_lua_server)
