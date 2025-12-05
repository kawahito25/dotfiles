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
        --[[ I do not recommend using alternative loading strategies such as event = 'VimEnter' or event = 'CursorMoved' as match-up already loads a minimal amount of code on start-up.
        It may work, but if you run into issues, remove the event key as a first debugging step. ]]
        event = { 'VimEnter', 'CursorMoved' },
        init = function()
            -- modify your configuration vars here
            vim.g.matchup_treesitter_stopline = 500

            -- or call the setup function provided as a helper. It defines the
            -- configuration vars for you
            require('match-up').setup({
                treesitter = {
                    stopline = 500
                }
            })
        end,
        -- or use the `opts` mechanism built into `lazy.nvim`. It calls
        -- `require('match-up').setup` under the hood
        opts = {
            treesitter = {
                stopline = 500,
            }
        }
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
