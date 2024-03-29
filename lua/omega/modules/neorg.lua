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
                    icons = {
                        todo = {
                            done = {
                                icon = "󰸞",
                            },
                            on_hold = {
                                icon = "󰏤",
                            },
                            urgent = {
                                icon = "󱈸",
                            },
                            uncertain = {
                                icon = "",
                            },
                            recurring = {
                                icon = "",
                            },
                            pending = {
                                icon = "",
                            },
                        },
                    },
                },
            },
            ["core.keybinds"] = {
                config = {
                    default_keybinds = true,
                    neorg_leader = ",",
                    hook = function(keybinds)
                        keybinds.map("norg", "n", keybinds.leader .. "Tc", function()
                            vim.cmd.Neorg({ args = { "tangle", "current-file" } })
                        end)
                    end,
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
        { "max397574/neorg-contexts" },
    },
}

function neorg_mod.config(_, opts)
    require("lazy").load({ plugins = { "nvim-treesitter" } })
    require("neorg").setup(opts)
    vim.defer_fn(function()
        local ok, cmp = pcall(require, "cmp")
        if ok then
            local cmp_opts =
                require("lazy.core.plugin").values(require("lazy.core.config").plugins["nvim-cmp"], "opts", false)
            local neorg = require("neorg.core")
            local mod_ok = pcall(neorg.modules.load_module, "core.completion", {
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
