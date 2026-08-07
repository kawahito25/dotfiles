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
                enabled = false,
            }
        }
    },
    keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
}
