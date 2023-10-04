local which_key = {
    "folke/which-key.nvim",
    keys = { " " },
    -- event = "VeryLazy",
}

function which_key.config()
    require("which-key").setup({
        icons = {
            group = "",
        },
    })
    require("which-key").register({
        b = {
            name = "﩯Buffer",
        },
        t = {
            name = "  Tab",
        },
        f = {
            name = " Find",
        },
        h = {
            name = " Help",
        },
        L = {
            name = " Lazy",
        },
        s = {
            name = " Search",
        },
        v = {
            name = " View",
        },
        q = {
            name = " Quickfix",
        },
        g = {
            name = " Git",
        },
        i = {
            name = " Insert",
        },
        x = {
            name = " Errors",
        },
        T = {
            name = " Todo",
        },
    }, { prefix = "<leader>" })
end

return which_key
