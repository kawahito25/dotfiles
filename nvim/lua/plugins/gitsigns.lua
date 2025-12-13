return {
    "lewis6991/gitsigns.nvim",
    -- LazyVim の LazyFile イベントを真似た @see  https://github.com/LazyVim/LazyVim/discussions/1583#discussion-5700903
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    -- 公式ドキュメント:
    -- https://github.com/lewis6991/gitsigns.nvim
    --
    -- current_line_blame:
    --   true  にすると行末などに blame 情報が常時表示される
    --   false にしておくと控えめな挙動（必要時に :Gitsigns blame_line など）
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
        { "<leader>hs", function() require('gitsigns').stage_hunk() end, desc = "Stage / Unstage Current Hunks" },
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
