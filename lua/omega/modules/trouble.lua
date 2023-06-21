local trouble = {
    "folke/trouble.nvim",
}

trouble.keys = {
    { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics" },
    { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
    { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Location List" },
    { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List" },
    {
        "<leader>qp",
        function()
            if require("trouble").is_open() then
                require("trouble").previous({ skip_groups = true, jump = true })
            else
                pcall(vim.cmd.cprev)
            end
        end,
        desc = "Previous trouble/quickfix item",
    },
    {
        "<leader>qn",
        function()
            if require("trouble").is_open() then
                require("trouble").next({ skip_groups = true, jump = true })
            else
                pcall(vim.cmd.cnext)
            end
        end,
        desc = "Next trouble/quickfix item",
    },
}

return trouble
