local neorg_mod = {
    "nvim-neorg/neorg",
    ft = "norg",
    cmd = { "Neorg" },
    opts = {
        load = {
            ["core.defaults"] = {},
            ["core.concealer"] = {
                config = {
                    icon_preset = "diamond",
                },
            },
            ["core.keybinds"] = {
                config = {
                    default_keybinds = true,
                    neorg_leader = ",",
                },
            },
            ["core.dirman"] = {
                config = {
                    workspaces = {
                        notes = "~/notes",
                    },
                    default_workspace = "notes",
                },
            },
            ["core.journal"] = {
                config = {
                    workspace = "notes",
                    journal_folder = "journal",
                    strategy = "nested",
                },
            },
            ["core.export"] = {},
            ["core.export.markdown"] = {
                config = {
                    extensions = "all",
                },
            },
            ["core.integrations.telescope"] = {},
            ["external.context"] = {},
        },
    },
    dependencies = {
        { "nvim-neorg/neorg-telescope" },
        { "max397574/neorg-context" },
    },
}

function neorg_mod.config(_, opts)
    require("neorg").setup(opts)
    vim.defer_fn(function()
        local ok, cmp = pcall(require, "cmp")
        if ok then
            local cmp_opts =
                require("lazy.core.plugin").values(require("lazy.core.config").plugins["nvim-cmp"], "opts", false)
            local mod_ok = pcall(neorg.modules.load_module, "core.completion", nil, {
                engine = "nvim-cmp",
            })
            if mod_ok then
                table.insert(cmp_opts.sources, { name = "neorg", priority = 6 })
            end
            cmp.setup(cmp_opts)
        end
    end, 1)
end

return neorg_mod
