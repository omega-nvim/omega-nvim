local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufAdd", "BufEnter", "tabnew" }, {
    callback = function(args)
        if vim.t.bufs == nil then
            vim.t.bufs = vim.api.nvim_get_current_buf() == args.buf and {} or { args.buf }
        else
            local bufs = vim.t.bufs

            -- check for duplicates
            if
                vim.bo[args.buf].buflisted
                and (args.event == "BufEnter" or args.buf ~= vim.api.nvim_get_current_buf())
                and vim.api.nvim_buf_is_valid(args.buf)
                and (args.event == "BufEnter" or vim.bo[args.buf].buflisted)
                and not vim.tbl_contains(bufs, args.buf)
            then
                table.insert(bufs, args.buf)
                vim.t.bufs = bufs
            end
        end
    end,
})

autocmd("BufEnter", {
    callback = function(data)
        require("omega.extras.highlight_undo").setup(data.buf)
    end,
})

autocmd("BufDelete", {
    callback = function(args)
        for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
            local bufs = vim.t[tab].bufs
            if bufs then
                for i, bufnr in ipairs(bufs) do
                    if bufnr == args.buf then
                        table.remove(bufs, i)
                        vim.t[tab].bufs = bufs
                        break
                    end
                end
            end
        end
    end,
})

autocmd({ "BufNewFile", "BufRead", "TabEnter", "TermOpen" }, {
    callback = function()
        if #vim.fn.getbufinfo({ buflisted = 1 }) >= 2 or #vim.api.nvim_list_tabpages() >= 2 then
            vim.opt.showtabline = 2
        end
    end,
})

-- -- show cursor line only in active window
autocmd({ "InsertLeave", "WinEnter", "CmdlineLeave" }, {
    pattern = "*",
    command = "set cursorline",
    desc = "Enable cursorline",
})
autocmd({ "InsertEnter", "WinLeave", "CmdlineEnter" }, {
    pattern = "*",
    command = "set nocursorline",
    desc = "Disable cursorline",
})

-- Create directories inside which buffer is recursively
autocmd("BufWritePre", {
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
autocmd({ "BufRead" }, {
    pattern = "*",
    callback = function()
        require("omega.utils").last_place()
    end,
    desc = "Go to last position in buffer",
})

local last_cursor
-- Don't move cursor on yank
autocmd("CursorMoved", {
    callback = function()
        last_cursor = vim.api.nvim_win_get_cursor(0)
    end,
})

autocmd("TextYankPost", {
    callback = function()
        vim.api.nvim_win_set_cursor(0, last_cursor)
    end,
})

-- Enable bulitin treesitter
autocmd("FileType", {
    pattern = { "lua", "vim", "help", "c" },
    callback = function()
        vim.treesitter.start()
    end,
    desc = "Enable bulitin treesitter",
})

-- Strip indent from text yanked to clipboard
autocmd({ "TextYankPost" }, {
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
autocmd({ "TextYankPost" }, {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higrou = "IncSearch", timeout = 500 })
    end,
    group = vim.api.nvim_create_augroup("highlight_yank", {}),
    desc = "Highlight yanked text",
})

autocmd({ "FileType" }, {
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

autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        -- client.server_capabilities.semanticTokensProvider = nil
    end,
})

autocmd("CursorHold", {
    group = vim.api.nvim_create_augroup("lsp_float", {}),
    callback = function()
        vim.diagnostic.open_float()
    end,
})

autocmd("UIEnter", {
    once = true,
    callback = function()
        local ffi = require("ffi")
        local pnano = assert(ffi.new("nanotime[?]", 1))
        local CLOCK_PROCESS_CPUTIME_ID = jit.os == "OSX" and 12 or 2
        ffi.C.clock_gettime(CLOCK_PROCESS_CPUTIME_ID, pnano)
        _G.real_startuptime = tonumber(pnano[0].tv_sec) / 1e6 + tonumber(pnano[0].tv_nsec) / 1e6
    end,
})

autocmd("OptionSet", {
    callback = function(data)
        if data.match == "background" then
            loadfile(vim.fn.stdpath("cache") .. "/omega/highlights")()
        end
    end,
})

autocmd("FileType", {
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions
            + "r" -- continue comments after return
            + "c" -- wrap comments using textwidth
            + "q" -- allow to format comments w/ gq
            + "j" -- remove comment leader when joining lines when possible
            - "t" -- don't autoformat
            - "a" -- no autoformatting
            - "o" -- don't continue comments after o/O
            - "2" -- don't use indent of second line for rest of paragraph
    end,
    desc = "Set formatoptions",
})
