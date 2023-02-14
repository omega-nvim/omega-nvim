-- Create directories inside which buffer is recursively
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        if vim.tbl_contains({ "oil" }, vim.bo.ft) then
            return
        end
        local dir = vim.fn.expand("<afile>:p:h")
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end
    end,
    desc = "Create directories inside which buffer is recursively",
})

-- Go to last position in buffer
vim.api.nvim_create_autocmd({ "BufRead" }, {
    pattern = "*",
    callback = function()
        require("omega.utils").last_place()
    end,
    desc = "Go to last position in buffer",
})

-- Enable bulitin treesitter
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua", "vim", "help", "c" },
    callback = function()
        vim.treesitter.start()
    end,
    desc = "Enable bulitin treesitter",
})

-- Strip indent from text yanked to clipboard
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
        if vim.v.event.regname ~= "+" then
            return
        end
        local contents = vim.split(vim.fn.getreg("+"), "\n")
        local min_spaces = 10000
        local new_contents = {}
        if not contents or #contents == 0 then
            return
        end
        for _, line in ipairs(contents) do
            if #line ~= 0 then
                min_spaces = math.min(min_spaces, #(line:match("^%s*")))
            end
        end
        for _, line in ipairs(contents) do
            table.insert(new_contents, line:sub(min_spaces + 1, -1))
        end
        vim.fn.setreg("+", table.concat(new_contents, "\n"))
    end,
    desc = "Strip indent from text yanked to clipboard",
})

-- Highlight yanked text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higrou = "IncSearch", timeout = 500 })
    end,
    group = vim.api.nvim_create_augroup("highlight_yank", {}),
    desc = "Highlight yanked text",
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "help", "startuptime", "qf", "lspinfo", "man", "tsplayground" },
    callback = function()
        vim.keymap.set("n", "q", function()
            vim.cmd.close()
        end, {
            noremap = true,
            silent = true,
            buffer = true,
        })
    end,
    desc = "Map q to close some buffers",
})
