local color_viewer = {}

function color_viewer.view_colors()
    local colors = require("omega.colors.themes." .. vim.g.colors_name)
    local color_names = vim.tbl_keys(colors.colors)
    table.sort(color_names)
    local ns = vim.api.nvim_create_namespace("color_viewer")
    local lines = { " Colors", "" }
    for _, name in ipairs(color_names) do
        table.insert(lines, "  " .. name .. ": " .. colors.colors[name])
    end
    for i = 0, 15, 1 do
        lines[i + 2] = lines[i + 2]
            .. string.rep(" ", 30 - #lines[i + 2])
            .. "  base"
            .. string.format("%02X", i)
            .. ": "
            .. colors.base16["base" .. string.format("%02X", i)]
    end
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
    vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>q<CR>", { noremap = true, silent = true, nowait = true })
    vim.api.nvim_buf_set_keymap(buf, "n", "<ESC>", "<cmd>q<CR>", { noremap = true, silent = true, nowait = true })
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    local width = vim.api.nvim_win_get_width(0)
    local height = vim.api.nvim_win_get_height(0)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "win",
        win = 0,
        width = 55,
        height = 35,
        col = 5,
        row = 0,
        border = "single",
        style = "minimal",
    })
    vim.api.nvim_win_set_option(win, "winblend", 0)
    vim.api.nvim_buf_set_option(buf, "modifiable", false)
    vim.api.nvim_buf_add_highlight(buf, ns, "Special", 0, 0, -1)
    vim.cmd.ColorizerAttachToBuffer()
end

return color_viewer
