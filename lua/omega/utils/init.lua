local utils = {}

--- Picks a random element of a table
---@param table table
---@return any Random-element
function utils.random_element(table)
    math.randomseed(os.clock())
    local index = math.random() * #table
    return table[math.floor(index) + 1]
end

local read_buffers = {}
--- Go to last place in file
function utils.last_place()
    if not vim.tbl_contains(vim.api.nvim_list_bufs(), vim.api.nvim_get_current_buf()) then
        return
    elseif vim.tbl_contains(read_buffers, vim.api.nvim_get_current_buf()) then
        return
    end
    table.insert(read_buffers, vim.api.nvim_get_current_buf())
    -- check if filetype isn't one of the listed
    if not vim.tbl_contains({ "gitcommit", "help", "packer", "toggleterm" }, vim.bo.ft) then
        -- check if mark `"` is inside the current file (can be false if at end of file and stuff got deleted outside neovim)
        -- if it is go to it
        vim.cmd([[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]])
        -- get cursor position
        local cursor = vim.api.nvim_win_get_cursor(0)
        -- if there are folds under the cursor open them
        if vim.fn.foldclosed(cursor[1]) ~= -1 then
            vim.cmd.normal({ "zO", bang = true })
        end
    end
end

return utils
