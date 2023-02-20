local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
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

return live_grep_selected
