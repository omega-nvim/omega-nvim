local cmp_module = {
    "max397574/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        {
            "saadparwaiz1/cmp_luasnip",
        },
        {
            "hrsh7th/cmp-emoji",
        },
        {
            "hrsh7th/cmp-path",
        },
        {
            "kdheepak/cmp-latex-symbols",
        },
        {
            "hrsh7th/cmp-nvim-lsp",
        },
    },
    opts = function()
        local config = require("omega.custom.config")
        local luasnip = require("luasnip")
        local cmp = require("cmp")
        local kind = require("omega.modules.lsp.kind")
        local types = require("cmp.types")
        local str = require("cmp.utils.str")

        local function get_abbr(_, entry)
            local word = entry:get_insert_text()
            if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
                word = vim.lsp.util.parse_snippet(word)
            end
            word = str.oneline(word)
            local max = 50
            if string.len(word) >= max then
                local before = string.sub(word, 1, math.floor((max - 3) / 2))
                word = before .. "..."
            end

            return word
        end
        local border
        if config.ui.cmp.border == "half" then
            border = {
                { "▄", "CmpBorder" },
                { "▄", "CmpBorder" },
                { "▄", "CmpBorder" },
                { "█", "CmpBorder" },
                { "▀", "CmpBorder" },
                { "▀", "CmpBorder" },
                { "▀", "CmpBorder" },
                { "█", "CmpBorder" },
            }
        elseif config.ui.cmp.border == "none" then
            border = "none"
        elseif config.ui.cmp.border == "rounded" then
            border = {
                { "╭", "CmpBorder" },
                { "─", "CmpBorder" },
                { "╮", "CmpBorder" },
                { "│", "CmpBorder" },
                { "╯", "CmpBorder" },
                { "─", "CmpBorder" },
                { "╰", "CmpBorder" },
                { "│", "CmpBorder" },
            }
        end
        local fields = {}
        local field_aliases = {
            type = "menu",
            kind_icon = "kind",
            text = "abbr",
        }
        for _, field in ipairs(config.ui.cmp.fields) do
            table.insert(fields, field_aliases[field] or field)
            table.insert(fields, "padding")
        end
        table.remove(fields, #fields)

        return {
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            window = {
                completion = {
                    border = border,
                    winhighlight = "Normal:CmpNormal,FloatBorder:CmpDocumentationBorder,Search:None,CursorLine:CmpSelected",
                    left_side_padding = 0,
                    right_side_padding = 1,
                    col_offset = 1,
                },
                documentation = {
                    border = "rounded",
                    winhighlight = "FloatBorder:CmpDocumentationBorder,Search:None",
                    max_width = 80,
                    col_offset = -1,
                    max_height = 12,
                },
            },
            formatting = {
                fields = fields,
                format = function(entry, item)
                    item.menu = item.kind
                    item.menu_hl_group = ("CmpItemKindMenu%s"):format(item.kind)
                    item.padding = " "
                    item.kind = kind.presets.default[item.kind] or ""
                    item.source_hl_group = "CmpSource"
                    item.dup = ({
                        buffer = 1,
                        path = 1,
                        nvim_lsp = 0,
                    })[entry.source.name] or 0
                    item.source = entry.source.name
                    if item.abbr == "" then
                        item.dup = 1
                    end

                    item.abbr = get_abbr(item, entry)

                    return item
                end,
            },
            mapping = {
                ["<C-f>"] = cmp.mapping(function(fallback)
                    if cmp.visible() and cmp.get_selected_entry() then
                        cmp.scroll_docs(4)
                    elseif luasnip.choice_active() then
                        require("luasnip").change_choice(1)
                    else
                        fallback()
                    end
                end, {
                    "i",
                    "s",
                }),
                ["<C-d>"] = cmp.mapping(function(fallback)
                    if cmp.visible() and cmp.get_selected_entry() then
                        cmp.scroll_docs(-4)
                    elseif luasnip.choice_active() then
                        require("luasnip").change_choice(-1)
                    else
                        fallback()
                    end
                end, {
                    "i",
                    "s",
                }),

                ["<c-j>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item({
                            behavior = cmp.SelectBehavior.Insert,
                        })
                    elseif luasnip.jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, {
                    "i",
                    "s",
                }),

                ["<c-k>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item({
                            behavior = cmp.SelectBehavior.Insert,
                        })
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, {
                    "i",
                    "s",
                }),

                ["<c-space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),

                ["<C-e>"] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                }),

                ["<CR>"] = cmp.mapping({
                    i = cmp.mapping.confirm({
                        select = true,
                        behavior = cmp.ConfirmBehavior.Insert,
                    }),
                    c = cmp.mapping.confirm({
                        select = false,
                        behavior = cmp.ConfirmBehavior.Insert,
                    }),
                }),
            },

            sources = {
                { name = "path", priority = 5 },
                { name = "emoji", priority = 3 },
                { name = "nvim_lsp", priority = 9 },
                { name = "luasnip", priority = 8 },
                { name = "latex_symbols", priority = 1 },
            },
            enabled = function()
                if vim.bo.ft == "TelescopePrompt" then
                    return false
                end
                if luasnip.choice_active() then
                    return false
                end
                if vim.bo.ft == "lua" then
                    return true
                end
                local lnum, col = vim.fn.line("."), math.min(vim.fn.col("."), #vim.fn.getline("."))
                for _, syn_id in ipairs(vim.fn.synstack(lnum, col)) do
                    syn_id = vim.fn.synIDtrans(syn_id)
                    if vim.fn.synIDattr(syn_id, "name") == "Comment" then
                        return false
                    end
                end
                if string.find(vim.api.nvim_buf_get_name(0), "neorg://") then
                    return false
                end
                if string.find(vim.api.nvim_buf_get_name(0), "s_popup:/") then
                    return false
                end
                return true
            end,
            sorting = {
                comparators = cmp.config.compare.recently_used,
            },
            experimental = {
                ghost_text = true,
            },
        }
    end,
}

function cmp_module.config(_, opts)
    local cmp = require("cmp")
    if require("lazy.core.config").plugins["nvim-autopairs"] then
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
    end
    if not neorg then
        cmp.setup(opts)
        return
    end
    local ok = pcall(neorg.modules.load_module, "core.norg.completion", nil, {
        engine = "nvim-cmp",
    })
    if ok then
        table.insert(opts.sources, { name = "neorg", priority = 6 })
    end
    cmp.setup(opts)
end

return cmp_module
