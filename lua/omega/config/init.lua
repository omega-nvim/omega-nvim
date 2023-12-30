local M = {}

local defaults = {
    keymaps = true,
    autocmds = true,
    colorscheme = "onedark",
}

local options

function M.setup(opts)
    vim.t.bufs = vim.api.nvim_list_bufs()
    options = vim.tbl_deep_extend("force", defaults, opts)
    -- HACK: autocmds can be loaded lazily when not opening a file
    local lazy_autocmds = vim.fn.argc(-1) == 0
    if not lazy_autocmds then
        if options.autocmds then
            require("omega.core.autocommands")
        end
        require("omega.autocommands")
    end
    vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
            if options.keymaps then
                require("omega.core.mappings")
            end
            require("omega.mappings")
            require("omega.core.commands")
            if lazy_autocmds then
                require("omega.autocommands")
                if options.autocmds then
                    require("omega.core.autocommands")
                end
            end
        end,
    })
end

local did_init = false
function M.init()
    if did_init then
        return
    end
    did_init = true
    local plugin = require("lazy.core.config").spec.plugins["omega-nvim"]
    if plugin then
        vim.opt.rtp:append(plugin.dir)
    end
    require("omega.core.settings")
end

setmetatable(M, {
    __index = function(_, key)
        if options == nil then
            return vim.deepcopy(defaults)[key]
        end
        return options[key]
    end,
})

return M
