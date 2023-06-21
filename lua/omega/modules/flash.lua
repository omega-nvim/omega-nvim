local flash = {
    "folke/flash.nvim",
    opts = {
        jump = {
            autojump = true,
        },
        highlight = {
            label = {
                current = true,
                before = true,
                after = false,
            },
        },
    },
}

local function get_windows()
    local wins = vim.api.nvim_tabpage_list_wins(0)
    local curr_win = vim.api.nvim_get_current_win()
    local function check(win)
        local config = vim.api.nvim_win_get_config(win)
        return (config.focusable and (config.relative == "") and (win ~= curr_win))
    end
    return vim.tbl_filter(check, wins)
end

local function jump_windows()
    require("flash").jump({
        search = { multi_window = true, wrap = true },
        highlight = { backdrop = true, label = { current = true } },
        matcher = function()
            return vim.tbl_map(function(window)
                local wininfo = vim.fn.getwininfo(window)[1]
                return {
                    pos = { wininfo.topline, 1 },
                    end_pos = { wininfo.topline, 0 },
                }
            end, get_windows())
        end,
        action = function(match, _)
            vim.api.nvim_set_current_win(match.win)
            vim.api.nvim_win_call(match.win, function()
                vim.api.nvim_win_set_cursor(match.win, { match.pos[1], 0 })
            end)
        end,
    })
end

local function jump_lines()
    require("flash").jump({
        search = { multi_window = true, wrap = true },
        highlight = { backdrop = true, label = { current = true } },
        matcher = function()
            local results = {}
            for i = vim.fn.line("w0"), vim.fn.line("w$") do
                table.insert(results, {
                    pos = { i, 1 },
                    end_pos = { i, 0 },
                })
            end
            return results
        end,
        action = function(match, _)
            vim.api.nvim_set_current_win(match.win)
            vim.api.nvim_win_call(match.win, function()
                vim.api.nvim_win_set_cursor(match.win, { match.pos[1], 0 })
            end)
        end,
    })
end

vim.keymap.set("o", "<c-w>", function()
    local operator = vim.v.operator
    local register = vim.v.register
    vim.api.nvim_feedkeys(vim.keycode("<esc>"), "o", true)
    vim.schedule(function()
        require("flash").jump({
            action = function(match, state)
                local op_func = vim.go.operatorfunc
                local saved_view = vim.fn.winsaveview()
                vim.api.nvim_set_current_win(match.win)
                vim.api.nvim_win_set_cursor(match.win, match.pos)
                _G.flash_op = function()
                    local start = vim.api.nvim_buf_get_mark(0, "[")
                    local finish = vim.api.nvim_buf_get_mark(0, "]")
                    vim.api.nvim_cmd({ cmd = "normal", bang = true, args = { "v" } }, {})
                    vim.api.nvim_win_set_cursor(0, { start[1], start[2] })
                    vim.cmd("normal! o")
                    vim.api.nvim_win_set_cursor(0, { finish[1], finish[2] })
                    vim.api.nvim_input('"' .. register .. operator)

                    vim.schedule(function()
                        vim.api.nvim_set_current_win(state.win)
                        vim.fn.winrestview(saved_view)
                        vim.go.operatorfunc = op_func
                    end)

                    _G.flash_op = nil
                end
                vim.go.operatorfunc = "v:lua.flash_op"
                vim.api.nvim_feedkeys("g@", "n", false)
            end,
        })
    end)
end)

flash.keys = {
    {
        "s",
        mode = { "n", "x", "o" },
        function()
            require("flash").jump()
        end,
    },
    {
        "*",
        mode = { "n" },
        function()
            require("flash").jump({
                pattern = vim.fn.expand("<cword>"),
            })
        end,
    },
    {
        "S",
        mode = { "o", "x" },
        function()
            require("flash").treesitter()
        end,
    },
    {
        "<c-w><c-w>",
        mode = { "n" },
        function()
            jump_windows()
        end,
    },
    {
        "<c-e>",
        mode = { "n" },
        function()
            jump_lines()
        end,
    },
}

return flash
