local function on_attach(client, bufnr)
    require("omega.modules.lsp.on_attach").setup(client, bufnr)
end

local settings = {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    "vim",
                    "omega",
                    "hs",
                    "lvim",
                    "neorg",
                },
            },
            completion = {
                callSnippet = "Replace",
                displayContext = 5,
                showWord = "Enable",
            },
            hint = {
                enable = true,
                paramType = true,
                setType = true,
                paramName = true,
                arrayIndex = "Enable",
            },
            hover = {
                expandAlias = false,
            },
            type = {
                castNumberToInteger = true,
            },
            workspace = {
                checkThirdParty = false,
                maxPreload = 1000,
                preloadFileSize = 1000,
                library = {
                    vim.fn.stdpath("config") .. "/lua/omega/types",
                    vim.fn.stdpath("config") .. "/lua",
                },
            },
        },
    },
}

local function setup(opts)
    local libraries = {}

    local function add(lib, filter)
        ---@diagnostic disable-next-line: param-type-mismatch
        for _, p in ipairs(vim.fn.expand(lib .. "/lua", false, true)) do
            local plugin_name = vim.fn.fnamemodify(p, ":h:t")
            p = vim.loop.fs_realpath(p)
            if p and (not filter or filter[plugin_name]) then
                table.insert(libraries, p)
            end
        end
    end

    add("$VIMRUNTIME")

    if opts.plugins then
        ---@type table<string, boolean>
        local filter
        if type(opts.plugins) == "table" then
            filter = {}
            for _, p in pairs(opts.plugins) do
                filter[p] = true
            end
        end
        for _, site in pairs(vim.split(vim.o.packpath, ",")) do
            add(site .. "/pack/*/opt/*", filter)
            add(site .. "/pack/*/start/*", filter)
        end
        -- add support for lazy.nvim
        if package.loaded["lazy"] then
            for _, plugin in ipairs(require("lazy").plugins()) do
                add(plugin.dir, filter)
            end
        end
    end

    settings.settings.Lua.workspace.library = vim.fn.extend(settings.settings.Lua.workspace.library, libraries)

    require("lspconfig")["lua_ls"].setup(settings)
end

return { setup = setup }
