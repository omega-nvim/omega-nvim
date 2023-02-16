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
}

function telescope.config()
    local action_layout = require("telescope.actions.layout")
    local actions_layout = require("telescope.actions.layout")
    local fb_actions = require("telescope._extensions.file_browser.actions")
    local themes = require("telescope.themes")
    local resolve = require("telescope.config.resolve")
    local p_window = require("telescope.pickers.window")
    local if_nil = vim.F.if_nil
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local finders = require("telescope.finders")
    local pickers = require("telescope.pickers")
    local previewers = require("telescope.previewers")
    local make_entry = require("telescope.make_entry")
    local conf = require("telescope.config").values
    local sorters = require("telescope.sorters")

    --- Live grep the currently selected entries.
    --- This works with folders in the telescope file browser and with files.
    ---@param prompt_bufnr number
    local function live_grep_selected(prompt_bufnr)
        local opts = {}
        local picker = action_state.get_current_picker(prompt_bufnr)
        local entries = picker:get_multi_selection()
        opts.cwd = entries[1].cwd
        local search_list = {}

        for _, entry in ipairs(entries) do
            table.insert(search_list, entry[1])
        end
        actions.close(prompt_bufnr)
        local live_grepper = finders.new_job(function(prompt)
            local vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
            }

            local additional_args = {}

            return vim.tbl_flatten({
                vimgrep_arguments,
                additional_args,
                "--",
                prompt,
                search_list,
            })
        end, make_entry.gen_from_vimgrep(opts), opts.max_results, opts.cwd)
        pickers
            .new(opts, {
                prompt_title = "Live Grep",
                finder = live_grepper,
                previewer = conf.grep_previewer(opts),
                sorter = sorters.highlighter_only(opts),
            })
            :find()
    end
    require("lazy").load({ plugins = { "telescope-fzf-native.nvim" } })

    require("telescope").setup({
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
                preview_cutoff = 70, -- disable preview when less than 70 loc are available
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
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<C-d>"] = actions.preview_scrolling_up,
                    ["<C-f>"] = actions.preview_scrolling_down,
                    ["<C-h>"] = "which_key",
                    ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    ["<C-a>"] = actions.send_to_qflist + actions.open_qflist,
                    ["<C-s>"] = live_grep_selected,
                    ["<C-o>"] = actions.select_vertical,
                    ["<C-l>"] = actions_layout.toggle_preview,
                },
                i = {
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<C-d>"] = actions.preview_scrolling_up,
                    ["<C-f>"] = actions.preview_scrolling_down,
                    ["<C-h>"] = "which_key",
                    ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    ["<C-a>"] = actions.send_to_qflist + actions.open_qflist,
                    ["<C-s>"] = live_grep_selected,
                    ["<C-o>"] = actions.select_vertical,
                    ["<C-l>"] = actions_layout.toggle_preview,

                    ["<C-c>"] = fb_actions.create,
                    ["<a-cr>"] = fb_actions.create_from_prompt,
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
    })
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("file_browser")
end

return telescope
