local to_move_next = function(q, group)
    return function() require("nvim-treesitter-textobjects.move").goto_next_start(q, group or "textobjects") end
end
local to_move_prev = function(q, group)
    return function() require("nvim-treesitter-textobjects.move").goto_previous_start(q, group or "textobjects") end
end
local to_select = function(q, group)
    return function() require("nvim-treesitter-textobjects.select").select_textobject(q, group or "textobjects") end
end

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
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        init = function() vim.g.no_plugin_maps = true end,
        keys = {
            -- 移動 (move)
            { "]f", to_move_next("@function.outer"),        desc = "Next function" },
            { "[f", to_move_prev("@function.outer"),        desc = "Prev function" },
            { "]c", to_move_next("@class.outer"),           desc = "Next class" },
            { "[c", to_move_prev("@class.outer"),           desc = "Prev class" },
            { "]g", to_move_next("@conditional.outer"),     desc = "Next conditional" },
            { "[g", to_move_prev("@conditional.outer"),     desc = "Prev conditional" },
            { "]z", to_move_next("@fold", "folds"),         desc = "Next fold" },
            { "]s", to_move_next("@local.scope", "locals"), desc = "Next scope" },
            -- 選択 (select)
            { "af", to_select("@function.outer"),           mode = { "x", "o" },      desc = "Select outer function" },
            { "if", to_select("@function.inner"),           mode = { "x", "o" },      desc = "Select inner function" },
            { "ac", to_select("@class.outer"),              mode = { "x", "o" },      desc = "Select outer class" },
            { "ic", to_select("@class.inner"),              mode = { "x", "o" },      desc = "Select inner class" },
            { "ag", to_select("@conditional.outer"),        mode = { "x", "o" },      desc = "Select outer conditional" },
            { "ig", to_select("@conditional.inner"),        mode = { "x", "o" },      desc = "Select inner conditional" },
            { "as", to_select("@local.scope", "locals"),    mode = { "x", "o" },      desc = "Select scope" },
        },
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
            max_lines = 4,
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
    },
}
