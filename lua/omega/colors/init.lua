local colors = {}

-- credits to https://github.com/EdenEast/nightfox.nvim
function colors.compile_theme(theme)
    vim.g.colors_name = theme
    package.loaded["omega.colors.highlights"] = nil
    local highlights = require("omega.colors.highlights")
    local bg = require("omega.colors.themes." .. vim.g.colors_name).bg
    local lines = {
        string.format(
            [[
        require"omega.colors".compiled=string.dump(function()
            vim.g.colors_name=nil
            vim.opt.background="%s"
            vim.g.colors_name="%s"
            ]],
            bg,
            vim.g.colors_name
        ),
    }
    for group, values in pairs(highlights) do
        local options = ""
        for optionname, value in pairs(values) do
            if type(value) == "boolean" then
                value = tostring(value)
            else
                value = '"' .. value .. '"'
            end
            options = options .. optionname .. "=" .. value .. ","
        end
        table.insert(lines, string.format([[vim.api.nvim_set_hl(0,"%s", {%s})]], group, options))
    end
    local ok, custom = pcall(require, "omega.colors.custom." .. vim.g.colors_name)
    if ok then
        for group, values in pairs(custom.highlights or {}) do
            local options = ""
            for optionname, value in pairs(values) do
                if type(value) == "boolean" then
                    value = tostring(value)
                else
                    value = '"' .. value .. '"'
                end
                options = options .. optionname .. "=" .. value .. ","
            end
            table.insert(lines, string.format([[vim.api.nvim_set_hl(0,"%s", {%s})]], group, options))
        end
        for _, line in pairs(custom.code or {}) do
            table.insert(lines, line)
        end
    end
    table.insert(lines, "end)")
    local highlight_folder = vim.fn.stdpath("cache") .. "/omega/"
    if not vim.loop.fs_stat(highlight_folder) then
        vim.fn.mkdir(highlight_folder, "p")
    end
    local file = io.open(highlight_folder .. "highlights", "wb")
    if not file then
        print("error opening", highlight_folder .. "highlights")
        return
    end
    loadstring(table.concat(lines, "\n"), "=")()
    file:write(require("omega.colors").compiled)
    file:close()
end

function colors.new_theme(theme)
    vim.g.colors_name = theme
    package.loaded["omega.colors.highlights"] = nil
    package.loaded["omega.colors.custom"] = nil
    package.loaded["omega.custom.config"] = nil
    package.loaded["bufferline"] = nil
    package.loaded["heirline"] = nil
    require("omega.colors").compile_theme(theme)
    loadfile(vim.fn.stdpath("cache") .. "/omega/highlights")()
    vim.api.nvim_exec_autocmds("User", {
        pattern = "OmegaNewTheme",
        data = theme,
    })
end

return colors
