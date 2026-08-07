return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        delay = 400,
        -- presets: https://github.com/folke/which-key.nvim/blob/main/lua/which-key/presets.lua
        win = {
            width = math.huge,
            height = { min = 4, max = 25 },
            col = 0,
            row = -1,
            border = "rounded",
        },
        spec = {
            mode = { "n", "x" },
            { "<leader>c", group = "Choose" },
            { "<leader>g", group = "Go" },
            { "<leader>f", group = "Find" },
            { "<leader>h", group = "Hunk", icon = { icon = "", color = "cyan" } },
            { "<leader>o", group = "Open", icon = { icon = '󰏌', color = "blue" } },
            { "<leader>p", group = "Prettify", icon = { icon = "󰭈", color = "yellow" } },
            { "<leader>q", group = "Quickfix", icon = { icon = "󰷐", color = "orange" } },
            { "<leader>s", group = "Search" },
            { "<leader>u", group = "UI" },
        },
        -- default: https://github.com/folke/which-key.nvim/blob/3aab2147e74890957785941f0c1ad87d0a44c15a/lua/which-key/icons.lua#L16
        icons = {
            rules = {
                { pattern = 'reset', icon = '', color = 'red' },
            },
        },
    },
    keys = {
        {
            "<leader>?",
            function() require("which-key").show({ global = false }) end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
