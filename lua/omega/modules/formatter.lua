local formatter = {
    "mhartington/formatter.nvim",
    cmd = { "Format" },
}

formatter.config = function()
    require("formatter").setup({
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
            tex = {
                function()
                    return {
                        exe = "/usr/local/Cellar/latexindent/3.20.1/bin/latexindent",
                        args = {
                            "-g",
                            "/dev/null",
                        },
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
            query = {
                function()
                    return {
                        exe = "~/programming/rust/query-fmt/target/debug/query-fmt",
                        args = { vim.fn.expand("%"), "--preview" },
                        stdin = true,
                    }
                end,
            },
        },
    })
    vim.api.nvim_create_autocmd("User", {
        pattern = "FormatterPost",
        callback = function()
            vim.cmd.w()
        end,
    })
end

return formatter
