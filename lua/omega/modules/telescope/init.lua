local telescope = {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
}

telescope.dependencies = {
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
    },
    {
        "debugloop/telescope-undo.nvim",
    },
}

telescope.opts = {
    defaults = {
        file_ignore_patterns = {
            "^target",
            "%.aux",
            "%.toc",
            "%.pdf",
            "%.out",
            "%.log",
            "%.png",
            "%.jpg",
            "%.jpeg",
            ".repro/*",
            "build/*",
            ".docusaurus/*",
            "node_modules/*",
            ".DS_Store",
        },
        initial_mode = "insert",
        sorting_strategy = "ascending",
        prompt_prefix = "   ",
        selection_caret = "  ",
        get_status_text = function()
            return ""
        end,
        path_display = {
            shorten = {
                len = 2,
                exclude = { -1 },
            },
        },
        layout_config = {
            preview_cutoff = 90,
            prompt_position = "top",
            width = 0.85,
            height = 0.9,
            horizontal = {
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
        },
        mappings = {
            n = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
                ["<C-d>"] = "preview_scrolling_up",
                ["<C-f>"] = "preview_scrolling_down",
                ["<C-h>"] = "which_key",
                ["<C-q>"] = function(...)
                    require("telescope.actions").send_selected_to_qflist(...)
                    require("telescope.actions").open_qflist(...)
                end,
                ["<C-a>"] = function(...)
                    require("telescope.actions").send_to_qflist(...)
                    require("telescope.actions").open_qflist(...)
                end,
                ["<C-s>"] = function(...)
                    require("omega.modules.telescope.live_grep_selected")(...)
                end,
                ["<C-o>"] = "select_vertical",
                ["<C-l>"] = function(...)
                    require("telescope.actions.layout").toggle_preview(...)
                end,
            },
            i = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
                ["<C-d>"] = "preview_scrolling_up",
                ["<C-f>"] = "preview_scrolling_down",
                ["<C-h>"] = "which_key",
                ["<C-q>"] = function(...)
                    require("telescope.actions").send_selected_to_qflist(...)
                    require("telescope.actions").open_qflist(...)
                end,
                ["<C-a>"] = function(...)
                    require("telescope.actions").send_to_qflist(...)
                    require("telescope.actions").open_qflist(...)
                end,
                ["<C-o>"] = "select_vertical",
                ["<C-s>"] = function(...)
                    require("omega.modules.telescope.live_grep_selected")(...)
                end,
                ["<C-l>"] = function(...)
                    require("telescope.actions.layout").toggle_preview(...)
                end,

                ["<C-c>"] = function(...)
                    require("telescope._extensions.file_browser.actions").create(...)
                end,
                ["<a-cr>"] = function(...)
                    require("telescope._extensions.file_browser.actions").create_from_prompt(...)
                end,
            },
        },
    },
    pickers = {
        find_files = {
            find_command = {
                "rg",
                "-g",
                "!.git",
                "--files",
                "--hidden",
                "--no-ignore",
                "--smart-case",
            },
        },
        buffers = {
            theme = "dropdown",
            height = 0.3,
            width = 0.5,
            preview = {
                hide_on_startup = true,
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
    },
}

telescope.keys = {
    {
        "<leader>sh",
        mode = { "n" },
        function()
            require("telescope.builtin").highlights()
        end,
        { desc = " Search Highlights" },
    },
}

function telescope.config(_, opts)
    require("lazy").load({ plugins = { "telescope-fzf-native.nvim" } })

    require("telescope").setup(opts)
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("file_browser")
    require("telescope").load_extension("undo")
end

return telescope
