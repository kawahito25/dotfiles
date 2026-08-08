return {
    {
        'stevearc/quicker.nvim',
        ft = "qf",
        opts = {
            on_qf = function(bufnr)
                vim.keymap.set("n", "ze", function()
                    require("quicker").toggle_expand({ before = 2, after = 2, add_to_existing = true })
                end, {
                    buffer = bufnr,
                    desc = "Toggle expand / collapse",
                })
            end,
            keys = {
                {
                    "dd",
                    function()
                        vim.cmd("normal! dd")
                        vim.cmd("write")
                    end,
                    desc = "Delete line and update quickfix",
                },
            },
        },
        keys = {
            { "<leader>qq", function() require("quicker").toggle({ focus = true }) end, desc = "Toggle Quickfix" },
        },
    },
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        opts = {
            preview = {
                auto_preview = false,
                winblend = 0,
            },
            func_map = {
                ptoggleitem = "",
                ptoggleauto = "zp",
                filter      = "",
                filterr     = "",
                fzffilter   = "",
            }
        }
    },
}
