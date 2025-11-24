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
            virt_text = true,
            virt_text_pos = "eol",    -- 'eol' | 'overlay' | 'right_align'
            delay = 500,              -- default: 1000
            ignore_whitespace = true, -- default: false
            virt_text_priority = 100,
            use_focus = true,
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
        numhl                        = true,
    },
}
