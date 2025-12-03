return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
        jump = {
            -- automatically jump when there is only one match
            autojump = false,
        },
        modes = {
            -- options used when flash is activated through
            -- a regular search with `/` or `
            search = {
                -- when `true`, flash will be activated during regular search by default.
                -- You can always toggle when searching with `require("flash").toggle()`
                enabled = false, -- true にすると、タイプミス時に該当箇所に飛ぶリスクがある
            },
            -- options used when flash is activated through
            -- `f`, `F`, `t`, `T`, `;` and `,` motions
            char = {
                -- show jump labels
                jump_labels = true,
            }
        }
    },
    keys = {
        { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
        { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        -- 使いこなせないので、いったんコメントアウト
        --      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
        --      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,     desc = "Toggle Flash Search" },
    },
}
