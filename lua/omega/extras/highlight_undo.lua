local hl_undo = {}

local ns = vim.api.nvim_create_namespace("hl_undo")

local should_attach = false

local function on_bytes(_, bufnr, _, start_row, start_column, _, _, _, _, end_row, end_col, _)
    if not should_attach then
        return true
    end
    vim.schedule(function()
        vim.highlight.range(bufnr, ns, "IncSearch", { start_row, start_column }, {
            start_row + end_row,
            start_column + end_col,
        })
        vim.defer_fn(function()
            vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
        end, 400)
    end)
end

function hl_undo.setup(buffer)
    vim.keymap.set("n", "u", function()
        vim.api.nvim_buf_attach(buffer, false, {
            on_bytes = on_bytes,
        })
        should_attach = true
        vim.cmd.undo()
        should_attach = false
    end, { buffer = buffer })

    vim.keymap.set("n", "<c-r>", function()
        vim.api.nvim_buf_attach(buffer, false, {
            on_bytes = on_bytes,
        })
        should_attach = true
        vim.cmd.redo()
        should_attach = false
    end, { buffer = buffer })
end

return hl_undo
