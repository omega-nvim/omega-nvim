local on_attach = {}

local function lsp_highlight_document(client, bufnr)
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        vim.api.nvim_create_autocmd("CursorHold", {
            callback = function()
                vim.lsp.buf.document_highlight()
            end,
            buffer = bufnr,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            callback = function()
                vim.lsp.buf.clear_references()
            end,
            buffer = bufnr,
        })
    end
end

function on_attach.setup(client, bufnr)
    if client.server_capabilities.codeActionProvider then
        require("omega.modules.lsp.available_code_action").setup(bufnr)
    end
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, opts)
    vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("i", "<c-h>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<C-d>", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<C-f>", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>sc", function()
        vim.lsp.buf.code_action()
    end, { desc = " Search Code Actions" })
    vim.keymap.set("v", "<leader>sc", function()
        vim.lsp.buf.code_action()
    end, { desc = " Search Code Actions" })
    lsp_highlight_document(client, bufnr)
end

return on_attach
