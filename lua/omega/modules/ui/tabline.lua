-- With some of the code from nvchad

local api = vim.api
local fn = vim.fn
local cmd = vim.cmd

local tabline = {}

local tabnames = {}

local devicons = nil

function tabline.rename_tab()
    local number = fn.tabpagenr()
    vim.ui.input({ prompt = "Tab Name: " }, function(input)
        tabnames[number] = input
        cmd.redrawtabline()
    end)
end

function tabline.next_buf()
    local buffers = vim.t.bufs or {}
    for idx, buf in ipairs(buffers) do
        if api.nvim_get_current_buf() == buf then
            if idx == #buffers then
                cmd.b(1)
                return
            else
                cmd.b(buffers[idx + 1])
                return
            end
        end
    end
end

function tabline.prev_buf()
    local buffers = vim.t.bufs or {}
    for idx, buf in ipairs(buffers) do
        if api.nvim_get_current_buf() == buf then
            if idx == 1 then
                cmd.b(buffers[#buffers])
                return
            else
                cmd.b(buffers[idx - 1])
                return
            end
        end
    end
end

function tabline.close_tab()
    local buffers = vim.t.bufs or {}
    cmd.tabclose()
    for _, buf in ipairs(buffers) do
        cmd.bd(buf)
    end
end

function tabline.close_buf(bufnr)
    if vim.bo[bufnr].modified then
        print("Save the buffer!")
        return
    end
    bufnr = (bufnr == 0 or not bufnr) and api.nvim_get_current_buf() or bufnr
    tabline.prev_buf()
    cmd.bd(bufnr)
end

vim.cmd([[
function! NewTab(a, b, c, d)
  tabnew
endfunction

function! GotoTab(tabnr, b, c, d)
  execute a:tabnr..'tabnext'
endfunction

function! CloseTab(a, b, c, d)
  lua require("omega.modules.ui.tabline").close_tab()
endfunction

function! GotoBuf(bufnr, b, c, d)
  execute 'b'..a:bufnr
endfunction

function! CloseBuffer(bufnr, b, c, d)
  call luaeval('require("omega.modules.ui.tabline").close_buf(_A)', a:bufnr)
endfunction

function! ToggleTabs(a, b, c, d)
  let g:tabs_collapsed = !g:tabs_collapsed | redrawtabline
endfunction
]])

vim.g.tabs_collapsed = 0

local function highlight(group)
    return "%#" .. group .. "#"
end

local function fg_bg_highlight(fg_group, bg_group)
    local group = "Tabline" .. fg_group .. bg_group
    local fg = api.nvim_get_hl_by_name(fg_group, true).foreground
    local bg = api.nvim_get_hl_by_name(bg_group, true).background
    api.nvim_set_hl(0, group, { fg = fg, bg = bg })
    return highlight(group)
end

local function get_file_info(name, bufnr)
    if name == " No Name " then
        -- local padding = string.rep(" ", math.floor((24 - #name) / 2))
        local padding = "       "
        local selected = api.nvim_get_current_buf() == bufnr
        name = (selected and "%#TablineBufferSelected#" or "%#TablineBufferVisible#") .. name
        return padding .. name .. padding
    end
    if not devicons then
        devicons = require("nvim-web-devicons")
    end
    local icon, hl = devicons.get_icon(name, name:match("%a+$"), { default = true })
    local info = " " .. icon .. " " .. name .. " "
    local padding = string.rep(" ", math.floor((24 - #info) / 2))
    local selected = api.nvim_get_current_buf() == bufnr
    icon = (selected and fg_bg_highlight(hl, "TablineBufferSelected") or fg_bg_highlight(hl, "TablineBufferVisible"))
        .. " "
        .. icon
    name = (selected and "%#TablineBufferSelected#" or "%#TablineBufferVisible#")
        .. " "
        .. (#name > 20 and name:sub(1, 15) .. "..." or name)
        .. " "
    return padding .. icon .. name .. padding
end

local function bufferlist()
    local buffers = ""
    for _, bufnr in ipairs(vim.t.bufs or {}) do
        local name = (#api.nvim_buf_get_name(bufnr) ~= 0) and fn.fnamemodify(api.nvim_buf_get_name(bufnr), ":t")
            or " No Name "
        local close_button = "%" .. bufnr .. "@CloseBuffer@X%X "
        local selected = api.nvim_get_current_buf() == bufnr
        if selected then
            close_button = "%#TablineCloseButtonSelected#" .. close_button
        else
            close_button = "%#TablineCloseButtonVisible#" .. close_button
        end
        name = "%" .. bufnr .. "@GotoBuf@" .. get_file_info(name, bufnr) .. close_button
        buffers = buffers .. "%#TablineFill#" .. name
    end
    return buffers .. "%#TablineFill#" .. "%="
end

local function tablist()
    local result = ""
    local number_of_tabs = fn.tabpagenr("$")

    for i = 1, number_of_tabs, 1 do
        local selected = i == fn.tabpagenr()
        local tab_hl = (selected and "%#TablineTabSelected# ") or "%#TablineTab# "
        local name = tabnames[i] or tostring(i)
        result = result .. ("%" .. i .. "@GotoTab@" .. tab_hl .. name .. " ")
        result = (selected and result .. "%#TablineTabClose#" .. "%@CloseTab@  %X") or result
    end

    local new_tabtn = "%#TablineTabNew#%@NewTab@  %X"
    local tabstoggleBtn = "%#TablineTabToggle#%@ToggleTabs@ TABS %X"
    if vim.g.tabs_collapsed == 1 then
        return new_tabtn .. "%#TablineTabToggle#%@ToggleTabs@   %X" .. "%#TablineTabClose#" .. "%@CloseTab@  %X"
    else
        return new_tabtn .. tabstoggleBtn .. result
    end
end

function tabline.run()
    return bufferlist() .. tablist()
end

return tabline
