local neorg_mod = {
    "nvim-neorg/neorg",
    ft = "norg",
    cmd = { "Neorg" },
    opts = {
        load = {
            ["core.defaults"] = {},
            ["core.norg.concealer"] = {
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
            ["core.norg.dirman"] = {
                config = {
                    workspaces = {
                        notes = "~/notes",
                    },
                    default_workspace = "notes",
                },
            },
            ["core.norg.journal"] = {
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

return neorg_mod
