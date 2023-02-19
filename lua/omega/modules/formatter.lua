local formatter = {
    "mhartington/formatter.nvim",
    cmd = { "Format" },
    opts = {
        filetype = {
            lua = {
                function()
                    return {
                        exe = "stylua",
                        args = {
                            "--search-parent-directories",
                            "-",
                        },
                        stdin = true,
                    }
                end,
            },
            rust = {
                function()
                    return {
                        exe = "rustfmt",
                        stdin = true,
                    }
                end,
            },
            cpp = {
                function()
                    return {
                        exe = "uncrustify",
                        args = { "-q", "-l cpp" },
                        stdin = true,
                    }
                end,
            },
            json = {
                function()
                    return {
                        exe = "jq",
                        args = {},
                        stdin = true,
                    }
                end,
            },
        },
    },
}

formatter.config = function(_, opts)
    require("formatter").setup(opts)
    vim.api.nvim_create_autocmd("User", {
        pattern = "FormatterPost",
        callback = function()
            vim.cmd.w()
        end,
    })
end

return formatter
