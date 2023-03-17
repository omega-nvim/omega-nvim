local function on_attach(client, bufnr)
    require("omega.modules.lsp.on_attach").setup(client, bufnr)
end
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = {
    valueSet = { 1 },
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
}

require("lspconfig")["rust_analyzer"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    standalone = true,
    settings = {
        ["rust-analyzer"] = {
            editor = {
                formatOnType = true,
            },
            checkOnSave = {
                command = "clippy",
            },
            hover = {
                actions = {
                    references = {
                        enable = true,
                    },
                },
            },
        },
    },
})
