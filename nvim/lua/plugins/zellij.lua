return {
    {
        "swaits/zellij-nav.nvim",
        lazy = true,
        event = "VeryLazy",
        keys = {
            { "<c-h>", "<cmd>ZellijNavigateLeftTab<cr>",  { silent = true, desc = "navigate left or tab" } },
            { "<c-j>", "<cmd>ZellijNavigateDown<cr>",  { silent = true, desc = "navigate down" } },
            { "<c-k>", "<cmd>ZellijNavigateUp<cr>",    { silent = true, desc = "navigate up" } },
            { "<c-l>", "<cmd>ZellijNavigateRightTab<cr>", { silent = true, desc = "navigate right or tab" } },
        },
        config = function(_, opts)
            require("zellij-nav").setup(opts)

            -- ターミナルモード ('t') のキーマップ
            -- <C-\><C-n> でノーマルモードに戻ってからコマンドを実行させる
            vim.keymap.set('t', '<c-h>', [[<C-\><C-n><cmd>ZellijNavigateLeftTab<cr>]], { silent = true })
            vim.keymap.set('t', '<c-j>', [[<C-\><C-n><cmd>ZellijNavigateDown<cr>]], { silent = true })
            vim.keymap.set('t', '<c-k>', [[<C-\><C-n><cmd>ZellijNavigateUp<cr>]], { silent = true })
            vim.keymap.set('t', '<c-l>', [[<C-\><C-n><cmd>ZellijNavigateRightTab<cr>]], { silent = true })
        end,
        opts = {},
    }
}
