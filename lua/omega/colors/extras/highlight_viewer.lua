local function view_highlights()
    local bufnr = vim.api.nvim_create_buf(false, true)
    local output = vim.split(vim.fn.execute("highlight"), "\n")
    local hl_groups = {}
    for _, v in ipairs(output) do
        if v ~= "" then
            if v:sub(1, 1) == " " then
                local part_of_old = v:match("%s+(.*)")
                hl_groups[#hl_groups] = hl_groups[#hl_groups] .. part_of_old
            else
                table.insert(hl_groups, v)
            end
        end
    end

    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, hl_groups)
    for k, v in ipairs(hl_groups) do
        local startPos = string.find(v, "xxx", 1, true) - 1
        local endPos = startPos + 3
        local hlgroup = string.match(v, "([^ ]*)%s+.*")
        pcall(vim.api.nvim_buf_add_highlight, bufnr, 0, hlgroup, k - 1, startPos, endPos)
    end
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "q",
        "<cmd>q<CR>",
        { noremap = true, silent = true, nowait = true }
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<ESC>",
        "<cmd>q<CR>",
        { noremap = true, silent = true, nowait = true }
    )
    local width = vim.api.nvim_win_get_width(0)
    local height = vim.api.nvim_win_get_height(0)
    local win = vim.api.nvim_open_win(bufnr, true, {
        relative = "win",
        win = 0,
        width = math.floor(width * 0.8),
        height = math.floor(height * 0.8),
        col = 5,
        row = 0,
        border = "single",
        style = "minimal",
    })
    vim.api.nvim_win_call(win, function()
        vim.cmd.ColorizerAttachToBuffer()
    end)
end

return view_highlights
