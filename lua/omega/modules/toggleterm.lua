local toggleterm = {
    "akinsho/toggleterm.nvim",
}

local exp = vim.fn.expand

local files = {
    python = "python3 -i " .. exp("%:t"),
    julia = "julia " .. exp("%:t"),
    lua = "lua " .. exp("%:t"),
    applescript = "osascript " .. exp("%:t"),
    c = "gcc -o temp " .. exp("%:t") .. " && ./temp && rm ./temp",
    cpp = "clang++ -o temp " .. exp("%:t") .. " && ./temp && rm ./temp",
    java = "javac " .. exp("%:t") .. " && java " .. exp("%:t:r") .. " && rm *.class",
    rust = "cargo run",
    javascript = "node " .. exp("%:t"),
    typescript = "tsc " .. exp("%:t") .. " && node " .. exp("%:t:r") .. ".js",
}

local function run_file()
    vim.cmd.w()
    local command = files[vim.bo.filetype]
    if vim.bo.filetype == "rust" then
        if vim.tbl_isempty(vim.fs.find("cargo.toml", { upward = true })) then
            local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
            local file = io.open(vim.fn.stdpath("data") .. "/temp", "w")
            if not file then
                return
            end
            for _, line in ipairs(lines) do
                file:write(line)
            end
            file:close()
            command = "rustc -o "
                .. vim.fn.stdpath("data")
                .. "/tmp "
                .. vim.fn.expand("%")
                .. " && "
                .. vim.fn.stdpath("data")
                .. "/tmp"
                .. "&& rm "
                .. vim.fn.stdpath("data")
                .. "/tmp"

            require("toggleterm.terminal").Terminal
                :new({ cmd = command, close_on_exit = false, direction = "float" })
                :toggle()
            print("Running: " .. command)
            return
        end
    end
    if command ~= nil then
        require("toggleterm.terminal").Terminal:new({ cmd = command, close_on_exit = false }):toggle()
        print("Running: " .. command)
    end
end
local function toggle_lazygit()
    require("toggleterm.terminal").Terminal:new({ cmd = "lazygit", close_on_exit = true }):toggle()
end

toggleterm.init = function()
    vim.defer_fn(function()
        vim.keymap.set("n", "<leader>r", function()
            run_file()
        end, { noremap = true })
        vim.keymap.set("n", "<c-t>", function()
            require("toggleterm.terminal").Terminal:new({ close_on_exit = true }):toggle()
        end, {
            noremap = true,
            silent = true,
        })
        vim.keymap.set("n", "<c-g>", function()
            toggle_lazygit()
        end, {
            noremap = true,
            silent = true,
        })
        vim.keymap.set("t", "<c-g>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
        vim.keymap.set("t", "<c-t>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
    end, 1)
end

toggleterm.config = function()
    require("toggleterm").setup({
        hide_numbers = true,
        start_in_insert = true,
        insert_mappings = true,
        shade_terminals = true,
        shading_factor = "3",
        persist_size = true,
        close_on_exit = false,
        direction = "float",
        float_opts = {
            border = require("omega.utils").border(),
            winblend = 0,
            highlights = {
                border = "FloatBorder",
                background = "NormalFloat",
            },
        },
    })
end

return toggleterm
