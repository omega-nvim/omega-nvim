local function on_attach(client, bufnr)
    require("omega.modules.lsp.on_attach").setup(client, bufnr)
end
require("lspconfig")["rust_analyzer"].setup({
    on_attach = on_attach,
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
