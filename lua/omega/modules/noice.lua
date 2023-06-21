local noice = {
    "folke/noice.nvim",
    event = "VeryLazy",
    enabled = true,
}

function noice.config()
    local config = require("omega.custom.config")
    vim.o.lazyredraw = false
    local settings = {
        cmdline = {
            view = "cmdline",
        },
        lsp = {
            progress = {
                enabled = true,
            },
            override = {
                -- override the default lsp markdown formatter with Noice
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                -- override the lsp markdown formatter with Noice
                ["vim.lsp.util.stylize_markdown"] = true,
            },
        },
        routes = {
            {
                view = "notify",
                filter = { event = "msg_showmode" },
            },
            {
                view = "notify",
                filter = { find = "overly long" },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "written",
                },
                opts = { skip = true },
            },
        },
    }
    if vim.tbl_contains({ "bottom", "top" }, config.ui.cmdline.position) then
        settings.cmdline.view = nil
        settings.views = {
            cmdline_popup = {
                position = {
                    row = vim.o.lines - 3,
                    col = "50%",
                },
                size = {
                    width = math.floor(vim.o.columns * 0.9),
                    height = "auto",
                },
                win_options = {
                    conceallevel = 0,
                },
            },
            popupmenu = {
                position = {
                    row = vim.o.lines - 16,
                    col = "50%",
                },
                size = {
                    width = math.floor(vim.o.columns * 0.9),
                    height = 10,
                },
                border = {
                    style = "rounded",
                    padding = { 0, 1 },
                },
                win_options = {
                    winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                },
            },
        }
        if config.ui.cmdline.position == "top" then
            settings.views.cmdline_popup.position.row = 2
            settings.views.popupmenu.position.row = 5
        end
    end
    require("noice").setup(settings)
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.select = function(items, opts, on_choice)
        opts.format_item = opts.format_item or tostring
        local buf = vim.api.nvim_create_buf(false, true)
        local lines = {}
        for i, item in ipairs(items) do
            local text = opts.format_item(item)
            table.insert(lines, i .. ". " .. text)
        end

        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        local height = vim.api.nvim_win_get_height(0)
        local width = require("omega.utils").longest(lines)
        local winnr = vim.api.nvim_open_win(buf, false, {
            relative = "editor",
            width = math.max(width, 10),
            height = #lines,
            style = "minimal",
            border = "single",
            row = height - #items - 2,
            col = 2,
            title = { { "Choices", "NoiceCmdlineIcon" } },
        })
        vim.wo[winnr].winhighlight = "FloatBorder:NoiceCmdlineIcon"
        local index
        vim.ui.input({ prompt = "Select item: " }, function(idx)
            vim.api.nvim_win_close(winnr, true)
            index = tonumber(idx)
        end)
        if index == nil or index > #lines then
            return
        end
        on_choice(items[index])
    end
end

return noice
