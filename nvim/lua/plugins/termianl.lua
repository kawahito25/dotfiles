local function open_named_terminal(option)
    vim.ui.input({ prompt = 'Terminal Name: ' }, function(input)
        if input == nil or input == "" then
            vim.cmd("TermNew")
        else
            vim.cmd(string.format("TermNew name=%s %s", input, option))
        end
    end)
end

return {
    "akinsho/toggleterm.nvim",
    branch = "main",
    opts = {
        direction = 'float',
        size = function(term)
            if term.direction == "horizontal" then
                return 15
            elseif term.direction == "vertical" then
                return vim.o.columns * 0.5
            end
        end,
    },
    keys = {
        { "<leader>tt", "<cmd>ToggleTerm<cr>",                                      desc = "Terminal" },
        { "<leader>tf", function() open_named_terminal("direction=float") end,      desc = "Terminal (Float)" },
        { "<leader>tv", function() open_named_terminal("direction=vertical") end,   desc = "Terminal (Vertical)" },
        { "<leader>th", function() open_named_terminal("direction=horizontal") end, desc = "Terminal (Horizontal)" },
        { "<leader>tn", "<cmd>ToggleTermSetName<cr>",                               desc = "Set Terminal Name" },
        { "<leader>ts", "<cmd>TermSelect<cr>",                                      desc = "Select Terminal" }
    },
    config = function(_, opts)
        require("toggleterm").setup(opts)

        vim.api.nvim_create_autocmd("TermOpen", {
            pattern = "term://*toggleterm#*",
            callback = function()
                local opts = { buffer = 0 }
                vim.keymap.set('n', '<Esc>', [[<Cmd>ToggleTerm<CR>]], opts)
                vim.keymap.set('n', '<C-[>', [[<Cmd>ToggleTerm<CR>]], opts)
            end,
        })
    end
}
