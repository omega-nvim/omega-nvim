local term = {}

--- Opens a terminal
---@param direction "float"|"horizontal"|"vertical"|nil
---@return number,number # buf, term_id
function term.open(direction)
    direction = direction or "horizontal"
    local buf = vim.api.nvim_create_buf(false, true)
    vim.bo[buf].filetype = "terminal"
    vim.bo[buf].buflisted = false
    if direction == "float" then
        vim.api.nvim_open_win(buf, true, {
            relative = "editor",
            width = 100,
            height = 30,
            row = 5,
            col = 4,
        })
    elseif direction == "vertical" then
        vim.cmd.vsplit()
        vim.api.nvim_win_set_buf(0, buf)
        vim.api.nvim_set_option_value("number", false, { buf = buf })
        vim.api.nvim_set_option_value("relativenumber", false, { buf = buf })
    elseif direction == "horizontal" then
        vim.cmd.split()
        vim.api.nvim_win_set_buf(0, buf)
        vim.api.nvim_set_option_value("number", false, { buf = buf })
        vim.api.nvim_set_option_value("relativenumber", false, { buf = buf })
    end
    ---@type number
    ---@diagnostic disable-next-line: assign-type-mismatch
    local term_id = vim.fn.termopen(vim.o.shell)
    vim.cmd.startinsert()
    vim.keymap.set("t", "q", function()
        vim.api.nvim_chan_send(term_id, "exit\n")
    end)
    return buf, term_id
end

--- Runs a command in a terminal
---@param command string
---@param direction "float"|"horizontal"|"vertical"|nil
function term.run_command(command, direction)
    local buf, term_id = term.open(direction)
    vim.api.nvim_chan_send(term_id, command .. "\n")
end

return term
