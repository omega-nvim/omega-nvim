local components = {}
-- TODO: option to use dev icons
-- TODO: help file statusline
-- TODO: toggleterm statusline
-- TODO: clickable lsp
-- TODO: fix lsp
-- TODO: git (branch, diff, clickable -> lazygit)

local config = require("omega.custom.config")
local theme = require("omega.colors.themes." .. vim.g.colors_name)
local data = require("omega.modules.heirline.data")
local color_utils = require("omega.utils.colors")
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local statusline_theme = config.ui.statusline.color

local empty = { provider = "" }

local space = setmetatable({ provider = " " }, {
    __call = function(_, n)
        return { provider = string.rep(" ", n) }
    end,
})

local background_color
if statusline_theme == "blended" then
    background_color = theme.colors.one_bg
end

local left_separator = ({
    ["round"] = "",
    ["angled"] = "",
})[config.ui.statusline.separator_style]

local right_separator = ({
    ["round"] = "",
    ["angled"] = "",
})[config.ui.statusline.separator_style]

local priorities = {
    current_path = 60,
    workdir = 45,
    git_diff = 35,
    coords = 30,
    lsp = 10,
    word_count = 5,
}

local function blended_separator(color)
    return {
        fg = color_utils.blend_colors(color, background_color, 0.15),
        bg = theme.colors.black,
    }
end

local function blended_color(color)
    return {
        fg = color,
        bg = color_utils.blend_colors(color, background_color, 0.15),
    }
end

--- Creates a simple component
---@param main_provider function
---@param color string|function
---@param icon string
local function icon_component(main_provider, color, icon)
    -- TODO
    if statusline_theme == "blended" then
        return {
            {
                provider = left_separator,
                hl = (function()
                    if type(color) == "function" then
                        return function()
                            return blended_separator(color())
                        end
                    else
                        return blended_separator(color)
                    end
                end)(),
            },
            {
                provider = icon,
                hl = (function()
                    if type(color) == "function" then
                        return function()
                            return blended_color(color())
                        end
                    else
                        return blended_color(color)
                    end
                end)(),
            },
            {
                provider = right_separator,
                hl = (function()
                    if type(color) == "function" then
                        return function()
                            return {
                                fg = color_utils.blend_colors(color(), background_color, 0.15),
                                bg = background_color,
                            }
                        end
                    else
                        return {
                            fg = color_utils.blend_colors(color, background_color, 0.15),
                            bg = background_color,
                        }
                    end
                end)(),
            },
            {
                provider = " ",
                hl = {
                    bg = background_color,
                },
            },
            {
                provider = main_provider,
                hl = (function()
                    if type(color) == "function" then
                        return function()
                            return {
                                fg = color(),
                                bg = background_color,
                            }
                        end
                    else
                        return {
                            fg = color,
                            bg = background_color,
                        }
                    end
                end)(),
            },
            {
                provider = right_separator,
                hl = {
                    bg = theme.colors.black,
                    fg = background_color,
                },
            },
        }
    end
end

--- Creates a simple component
---@param main_provider function
---@param color string|function
---@param sep_left boolean
---@param sep_right boolean
local function simple_component(main_provider, color, sep_left, sep_right)
    local component = { {}, {}, {} }
    if sep_left then
        component[1].provider = left_separator
        -- TODO
        component[1].hl = (function()
            if statusline_theme == "blended" then
                if type(color) == "function" then
                    return function()
                        return blended_separator(color())
                    end
                else
                    return blended_separator(color)
                end
            end
        end)()
    end
    component[2] = {
        provider = main_provider,
        hl = (function()
            if statusline_theme == "blended" then
                if type(color) == "function" then
                    return function()
                        return blended_color(color())
                    end
                else
                    return blended_color(color)
                end
            end
        end)(),
    }
    if sep_right then
        component[3].provider = right_separator
        -- TODO
        component[3].hl = (function()
            if statusline_theme == "blended" then
                if type(color) == "function" then
                    return function()
                        return blended_separator(color())
                    end
                else
                    return blended_separator(color)
                end
            end
        end)()
    end
    return component
end

local function word_counter()
    local wc = vim.fn.wordcount()
    if wc["visual_words"] then
        return wc["visual_words"]
    else
        return wc["words"]
    end
end

local lsp_status

components.lsp_progress = {
    flexible = priorities.lsp,
    -- TODO
    -- update={"LspProgress"},
    update = function()
        return true
    end,
    condition = conditions.lsp_attached,
    hl = (function()
        if statusline_theme == "blended" then
            return {
                fg = theme.colors.blue,
            }
        end
    end)(),
    {
        provider = function()
            -- vim.api.nvim_create_autocmd("LspProgress", {
            --     group = vim.api.nvim_create_augroup("lsp_progress", {}),
            --     callback = function(data)
            --         local value = data.data.result.value
            --         if value.kind == "end" then
            --             lsp_status = ""
            --         else
            --             lsp_status = (value.percentage and value.percentage .. "%%: " or "")
            --                 .. (value.title or "")
            --                 .. " "
            --                 .. value.message
            --         end
            --     end,
            -- })
            -- return lsp_status

            local percentage = nil
            local groups = {}
            for _, client in ipairs(vim.lsp.get_active_clients()) do
                for progress in client.progress do
                    local value = progress.value
                    if type(value) == "table" and value.kind then
                        local group = groups[progress.token]
                        if not group then
                            group = {}
                            groups[progress.token] = group
                        end
                        group.title = value.title or group.title
                        group.message = value.message or group.message
                        if value.percentage then
                            percentage = math.max(percentage or 0, value.percentage)
                        end
                    end
                end
            end
            local messages = {}
            for _, group in pairs(groups) do
                if group.title then
                    table.insert(messages, group.message and (group.title .. ": " .. group.message) or group.title)
                elseif group.message then
                    table.insert(messages, group.message)
                end
            end
            local message = table.concat(messages, ", ")
            if percentage then
                return string.format("%3d%%%%: %s", percentage, message)
                -- return percentage.."%%: "..message
            end
            return message
            -- return vim.lsp.status():gsub("%%%%","%%")
        end,
    },
    empty,
}

local function progress_bar()
    local sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇" }
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)
    local i = math.floor(curr_line / lines * (#sbar - 1)) + 1
    return sbar[i]
end

components.progress_bar = icon_component(function()
    return " " .. progress_bar() .. " "
end, theme.colors.purple, "%3(%P%)")

components.coords = (function()
    local coords = {
        flexible = priorities.coords,
        {},
        empty,
    }
    -- TODO
    coords[1] = icon_component(function()
        return "%4(%l%):%2c"
    end, theme.colors.orange, "  ")
    return coords
end)()

components.mode_indicator = {
    init = function(self)
        self.mode = vim.fn.mode(1)
    end,
    condition = function()
        return vim.bo.buftype == ""
    end,
    {
        simple_component(function(self)
            return "%2(" .. data.mode_icons[self.mode:sub(1, 1)] .. "%)"
        end, function()
            return data.mode_colors[vim.fn.mode(1):sub(1, 1)] or theme.colors.blue
        end, false, true),
    },
}

components.word_count = {
    flexible = priorities.word_count,
    init = function(self)
        self.mode = vim.fn.mode(1)
    end,
    {
        -- Adds spacing so things don't shift around
        {
            provider = function()
                return string.rep(" ", 5 - #tostring(word_counter()))
            end,
        },
        simple_component(function()
            return word_counter() .. " "
        end, function()
            return data.mode_colors[vim.fn.mode(1):sub(1, 1)] or theme.colors.blue
        end, true, false),
    },
    empty,
}

components.file_name = (function()
    return {
        init = function(self)
            self.filename = vim.api.nvim_buf_get_name(0)
            local filename = self.filename
            local extension = vim.fn.fnamemodify(filename, ":e")
            self.current_path = vim.fn.fnamemodify(vim.fn.fnamemodify(filename, ":.h"), ":h") .. "/"
            self.filename = vim.fn.fnamemodify(filename, ":t")
            self.icon = data.file_icons[extension] or ""
        end,
        -- TODO
        hl = {
            bg = background_color,
        },
        on_click = {
            callback = function()
                print(vim.fn.expand("%"))
            end,
            name = "print_file_name",
        },
        condition = function()
            return not conditions.buffer_matches({
                buftype = { "nofile", "hidden" },
                filetype = { "NvimTree", "dashboard" },
            })
        end,

        {
            provider = left_separator,
            -- TODO
            hl = (function()
                if statusline_theme == "blended" then
                    return blended_separator(theme.colors.blue)
                end
            end)(),
        },
        {
            provider = function(self)
                return self.icon and self.icon
            end,
            -- TODO
            hl = (function()
                if statusline_theme == "blended" then
                    return {
                        fg = theme.colors.blue,
                        bg = color_utils.blend_colors(theme.colors.blue, background_color, 0.15),
                    }
                end
            end)(),
        },
        {
            provider = right_separator,
            -- TODO
            hl = (function()
                if statusline_theme == "blended" then
                    return {
                        fg = color_utils.blend_colors(theme.colors.blue, background_color, 0.15),
                        bg = background_color,
                    }
                end
            end)(),
        },
        {
            provider = " ",
            hl = {
                bg = background_color,
            },
        },
        {
            flexible = priorities.current_path,
            -- TODO
            hl = (function()
                if statusline_theme == "blended" then
                    return { fg = theme.colors.blue, bg = background_color }
                end
            end)(),
            {
                provider = function(self)
                    return self.current_path
                end,
            },
            {
                provider = function(self)
                    return vim.fn.pathshorten(self.current_path, 2)
                end,
            },
            empty,
        },
        {
            provider = function(self)
                return self.filename
            end,
            -- TODO
            hl = (function()
                if statusline_theme == "blended" then
                    return { fg = theme.colors.blue, bg = background_color }
                end
            end)(),
        },
        {
            {
                provider = function()
                    if vim.bo.modified then
                        return "  "
                    end
                end,
                -- TODO
                hl = (function()
                    if statusline_theme == "blended" then
                        return { fg = theme.colors.blue, bg = background_color }
                    end
                end)(),
            },
            {
                provider = function()
                    if not vim.bo.modifiable or vim.bo.readonly then
                        return "  "
                    end
                end,
                -- TODO
                hl = (function()
                    if statusline_theme == "blended" then
                        return { fg = theme.colors.blue, bg = background_color }
                    end
                end)(),
            },
        },
        {
            provider = right_separator,
            -- TODO
            hl = (function()
                if statusline_theme == "blended" then
                    return {
                        fg = background_color,
                        bg = theme.colors.black,
                    }
                end
            end)(),
        },
    }
end)()

components.current_dir = (function()
    local current_dir = {
        flexible = priorities.workdir,
        init = function(self)
            self.pwd = vim.fn.fnamemodify(vim.fn.getcwd(0), ":~")
        end,

        condition = function()
            if vim.bo.buftype == "" then
                return true
            end
        end,
        {},
        empty,
    }
    -- TODO
    current_dir[1] = icon_component(function(self)
        return self.pwd
    end, theme.colors.green, " ")
    return current_dir
end)()

components.diagnostics = {
    condition = conditions.has_diagnostics,
    static = {
        error_icon = " ",
        warn_icon = " ",
        info_icon = " ",
        hint_icon = " ",
    },
    -- TODO
    -- on_click = {
    --     callback = function()
    --         require("trouble").toggle({ mode = "document_diagnostics" })
    --     end,
    --     name = "heirline_diagnostics",
    -- },

    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,

    {
        provider = function(self)
            return self.errors > 0 and (self.error_icon .. self.errors .. " ")
        end,
        hl = { fg = utils.get_highlight("DiagnosticError").fg },
    },
    {
        provider = function(self)
            return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
        end,
        hl = { fg = utils.get_highlight("DiagnosticWarn").fg },
    },
    {
        provider = function(self)
            return self.info > 0 and (self.info_icon .. self.info .. " ")
        end,
        hl = { fg = utils.get_highlight("DiagnosticInfo").fg },
    },
    {
        provider = function(self)
            return self.hints > 0 and (self.hint_icon .. self.hints)
        end,
        hl = { fg = utils.get_highlight("DiagnosticHint").fg },
    },
}

return components
