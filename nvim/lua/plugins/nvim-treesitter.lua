return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "VeryLazy", "BufReadPost", "BufWritePost", "BufNewFile" },
        branch = "main",
        build = ":TSUpdate",
        highlight = { enable = true },
        fold = { enable = true },
        dependencies = {
            "RRethy/nvim-treesitter-endwise",
        },
        opts = {
            endwise = { enabled = true },
            indent = { enabled = true },
        },
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
        event = "InsertEnter",
        opts = {
            opts = {
                enable_close = true,
                enable_rename = true,
                enable_close_on_slash = false,
            },
            per_filetype = {
                html = { enable_close = false },
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        opts = {
            enabled = true,
        }
    },
    {
        'andymass/vim-matchup',
        event = "BufReadPost", -- @see https://www.reddit.com/r/neovim/comments/14w2cle/comment/jrfzjou/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
    },
    {
        'Wansmer/treesj',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('treesj').setup({
                --- Use default keymaps (<space>m - toggle, <space>j - join, <space>s - split)
                use_default_keymaps = false,
                --- number If line after join will be longer than max value, node will not be formatted
                max_join_length = 240,
            })
        end,
        keys = {
            -- p は pretty の略
            -- { '<leader>pm', function() require('treesj').toggle() end, mode = 'n', desc = 'Toggle (treesj)' },
            { '<leader>pj', function() require('treesj').join() end,  mode = 'n', desc = '(treesj)' },
            { '<leader>ps', function() require('treesj').split() end, mode = 'n', desc = 'split (treesj)' },
            {
                '<leader>pS',
                function()
                    require('treesj').toggle({
                        split = {
                            ---all nested configured nodes will process according to their presets
                            recursive = true
                        }
                    })
                end,
                mode = 'n',
                desc = 'Split recursively (treesj)'
            },
        }
    }
}
