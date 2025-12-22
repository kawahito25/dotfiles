return {
    {
        'stevearc/quicker.nvim',
        ft = "qf",
        opts = {
            on_qf = function(bufnr)
                vim.keymap.set("n", "<leader>qe", function()
                    require("quicker").toggle_expand({ before = 2, after = 2, add_to_existing = true })
                end, {
                    buffer = bufnr,
                    desc = "Toggle expand / collapse",
                })
            end,
        },
        keys = {
            { "<leader>qq", function() require("quicker").toggle({ focus = true }) end, desc = "Toggle Quickfix" },
        },
    },
    {
        "kevinhwang91/nvim-bqf",
        dependencies = {
            { "junegunn/fzf", build = "./install --bin" },
        },
        ft = "qf",
        opts = {
            preview = {
                winblend = 0,
            },
        }
    },
}
