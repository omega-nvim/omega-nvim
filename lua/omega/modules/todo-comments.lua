local todo_comments = {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    config = true,
}

todo_comments.keys = {
    {
        "<leader>Tn",
        function()
            require("todo-comments").jump_next()
        end,
        desc = " Next Todo",
    },
    {
        "<leader>Tp",
        function()
            require("todo-comments").jump_prev()
        end,
        desc = " Prev Todo",
    },
    { "<leader>Tt", "<cmd>TodoTrouble<cr>", desc = " Todo Trouble" },
    { "<leader>TT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = " Todo/Fix/Fixme Trouble" },
    { "<leader>st", "<cmd>TodoTelescope<cr>", desc = " Search Todos" },
    { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = " Search Todos Todo/Fix/Fixme" },
}

return todo_comments
