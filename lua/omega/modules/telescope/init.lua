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
        file_ignore_patterns = {},
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
                "-g",
                "!*.aux",
                "-g",
                "!*.toc",
                "-g",
                "!*.pdf",
                "-g",
                "!*.out",
                "-g",
                "!*.log",
                "-g",
                "!*.png",
                "-g",
                "!*.jpg",
                "-g",
                "!*.jpeg",
                "-g",
                "!.repro",
                "-g",
                "!*.idx",
                "-g",
                "!*.ind",
                "-g",
                "!*.ilg",
                "-g",
                "!*.fls",
                "-g",
                "!*.pygtex",
                "-g",
                "!*.pygstyle",
                "-g",
                "!*.synctex.gz",
                "-g",
                "!*.fdb_latexmk",
                "-g",
                "!build/",
                "-g",
                "!node_modules/",
                "-g",
                "!target/",
                "-g",
                "!.DS_Store",
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
    {
        "<leader>ff",
        function()
            require("telescope.builtin").find_files()
        end,
        desc = " Find file",
    },
    {
        "<leader>.",
        function()
            require("telescope").extensions.file_browser.file_browser()
        end,
        desc = " File Browser",
    },
    {
        "<leader>hh",
        function()
            require("telescope.builtin").help_tags()
        end,
        desc = " Help tags",
    },
    {
        "<leader>/",
        function()
            require("telescope.builtin").live_grep()
        end,
        desc = " Live Grep",
    },
    {
        "<c-s>",
        function()
            require("telescope.builtin").current_buffer_fuzzy_find()
        end,
        desc = "Current buffer fuzzy find",
    },
    {
        "<leader>,",
        function()
            require("telescope.builtin").buffers()
        end,
        desc = "﩯Buffers",
    },
}

function telescope.config(_, opts)
    require("lazy").load({ plugins = { "telescope-fzf-native.nvim" } })

    local hl_group = vim.api.nvim_create_augroup("norg-telescope-hl", { clear = true })
    vim.api.nvim_create_autocmd("User", {
        group = hl_group,
        pattern = "TelescopePreviewerLoaded",
        callback = function(args)
            if args.data.filetype == "norg" then
                vim.bo.filetype = "norg"
                vim.api.nvim_del_augroup_by_id(hl_group) -- Clear up once Neorg is loaded properly
                -- local neorg=require"neorg.core"
                -- local concealer = neorg.modules.get_module("core.dirman")
            end
        end,
    })

    require("telescope").setup(opts)
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("file_browser")
    require("telescope").load_extension("undo")
end

return telescope
