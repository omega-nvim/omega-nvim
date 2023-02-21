local treesitter = {
    "nvim-treesitter/nvim-treesitter",
    cmd = {
        "TSInstall",
        "TSBufEnable",
        "TSBufDisable",
        "TSEnable",
        "TSDisable",
        "TSModuleInfo",
    },
}

treesitter.opts = {
    ensure_installed = { "lua", "rust", "query" },
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,

        keymaps = {
            init_selection = "gnn",
            node_incremental = "gnn",
            scope_incremental = "gns",
            node_decremental = "gnp",
        },
    },
    playground = {
        enable = true,
        updatetime = 10,
        persist_queries = true,
    },
    query_linter = {
        enable = true,
        disable = function(_, buf)
            return #vim.api.nvim_buf_get_lines(buf, 0, -1, false) > 20
        end,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
    },
    endwise = { enable = true },
    indent = { enable = true, disable = { "python" } },
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["il"] = "@loop.inner",
                ["al"] = "@loop.outer",
                ["icd"] = "@conditional.inner",
                ["acd"] = "@conditional.outer",
                ["acm"] = "@comment.outer",
                ["ast"] = "@statement.outer",
                ["isc"] = "@scopename.inner",
                ["iB"] = "@block.inner",
                ["aB"] = "@block.outer",
                ["p"] = "@parameter.inner",
            },
        },

        move = {
            enable = true,
            set_jumps = true, -- Whether to set jumps in the jumplist
            goto_next_start = {
                ["gnf"] = "@function.outer",
                ["gnif"] = "@function.inner",
                ["gnp"] = "@parameter.inner",
                ["gnc"] = "@call.outer",
                ["gnic"] = "@call.inner",
            },
            goto_next_end = {
                ["gnF"] = "@function.outer",
                ["gniF"] = "@function.inner",
                ["gnP"] = "@parameter.inner",
                ["gnC"] = "@call.outer",
                ["gniC"] = "@call.inner",
            },
            goto_previous_start = {
                ["gpf"] = "@function.outer",
                ["gpif"] = "@function.inner",
                ["gpp"] = "@parameter.inner",
                ["gpc"] = "@call.outer",
                ["gpic"] = "@call.inner",
            },
            goto_previous_end = {
                ["gpF"] = "@function.outer",
                ["gpiF"] = "@function.inner",
                ["gpP"] = "@parameter.inner",
                ["gpC"] = "@call.outer",
                ["gpiC"] = "@call.inner",
            },
        },
    },
}

treesitter.dependencies = {
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    {
        "RRethy/nvim-treesitter-endwise",
    },
    {
        "nvim-treesitter/playground",
    },
}

function treesitter.init()
    if not vim.tbl_contains({ "[packer]", "" }, vim.fn.expand("%")) then
        require("lazy").load({ plugins = { "nvim-treesitter" } })
    else
        vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
            callback = function()
                local file = vim.fn.expand("%")
                if not vim.tbl_contains({ "[packer]", "" }, file) then
                    require("lazy").load({ plugins = { "nvim-treesitter" } })
                end
            end,
        })
    end
end

function treesitter.config(_, opts)
    vim.api.nvim_create_autocmd("InsertEnter", {
        callback = function()
            require("lazy").load({ plugins = { "nvim-treesitter-endwise" } })
        end,
    })

    require("lazy").load({ plugins = { "playground" } })

    require("nvim-treesitter.configs").setup(opts)
end

return treesitter
