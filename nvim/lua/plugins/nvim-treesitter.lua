return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = "main",
        build = ":TSUpdate",
        highlight = { enable = true },
        fold = { enable = true },
        dependencies = {
            "RRethy/nvim-treesitter-endwise",
        },
        opts = function(_, opts)
            opts.endwise = {
                enable = true
            }
        end,
        config = function(_, opts)
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("lazyvim_treesitter", { clear = true }),
                callback = function(ev)
                    pcall(vim.treesitter.start, ev.buf) -- highlighting
                end
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        event = "VeryLazy",
    },
    {
        "windwp/nvim-ts-autotag",
        event = "VeryLazy",
        opts = {
            -- Defaults
            enable_close = true,          -- Auto close tags
            enable_rename = true,         -- Auto rename pairs of tags
            enable_close_on_slash = false -- Auto close on trailing </
        },
    },
    -- TODO: https://github.com/andymass/vim-matchup を入れる
}
