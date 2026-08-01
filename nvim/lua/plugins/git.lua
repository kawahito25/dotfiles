return
{
    {
        'akinsho/git-conflict.nvim',
        version = "*",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require('git-conflict').setup({
                default_mappings = true,     -- デフォルトキーバインドを有効化
                disable_diagnostics = false, -- コンフリクト行のエラー波線等を無効化してすっきりさせる
            })

            local map = vim.keymap.set

            map('n', '<leader>co', '<Plug>(git-conflict-ours)', { desc = 'Git Conflict: Choose Ours' })
            map('n', '<leader>ct', '<Plug>(git-conflict-theirs)', { desc = 'Git Conflict: Choose Theirs' })
            map('n', '<leader>cb', '<Plug>(git-conflict-both)', { desc = 'Git Conflict: Choose Both' })
            map('n', '<leader>c0', '<Plug>(git-conflict-none)', { desc = 'Git Conflict: Choose None' })
            map('n', ']x', '<Plug>(git-conflict-next-conflict)', { desc = 'Git Conflict: Next Conflict' })
            map('n', '[x', '<Plug>(git-conflict-prev-conflict)', { desc = 'Git Conflict: Prev Conflict' })
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        -- LazyVim の LazyFile イベントを真似た @see  https://github.com/LazyVim/LazyVim/discussions/1583#discussion-5700903
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        -- 公式ドキュメント:
        -- https://github.com/lewis6991/gitsigns.nvim
        opts = {
            current_line_blame           = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts      = {
                virt_text         = true,
                virt_text_pos     = "right_align", -- 'eol' | 'overlay' | 'right_align'
                delay             = 0,             -- default: 1000
                ignore_whitespace = true,          -- default: false
                use_focus         = true,
            },
            current_line_blame_formatter = "<author> (<author_time:%R>) - <summary> [<abbrev_sha>]",
            signs                        = {
                add          = { text = '+' },
                change       = { text = '~' },
                delete       = { text = '-' },
                topdelete    = { text = '¯' },
                changedelete = { text = '±' },
                untracked    = { text = '?' },
            },
            signs_staged                 = {
                add          = { text = '+' },
                change       = { text = '~' },
                delete       = { text = '-' },
                topdelete    = { text = '¯' },
                changedelete = { text = '±' },
                untracked    = { text = '?' },
            },
        },
        keys = {
            -- Actions
            { "<leader>hs", function() require('gitsigns').stage_hunk() end, desc = "Toggle Stage Current Hunks" },
            { "<leader>hr", function() require('gitsigns').reset_hunk() end, desc = "Reset Current Hunks" },
            {
                '<leader>hs',
                function() require('gitsigns').stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
                mode = { "v" },
                desc = "Stage / Unstage Current Hunks"
            },
            {
                '<leader>hr',
                function() require('gitsigns').reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
                mode = { "v" },
                desc = "Reset Current Hunks"
            },
            -- Navigation
            {
                ']h',
                function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']c', bang = true })
                    else
                        require('gitsigns').nav_hunk('next', { target = "all" })
                    end
                end,
                mode = { "n" },
                desc = "next hunk"
            },
            {
                '[h',
                function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[c', bang = true })
                    else
                        require('gitsigns').nav_hunk('prev', { target = "all" })
                    end
                end,
                mode = { "n" },
                desc = "prev hunk"
            }
        },
    }
}
