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
            { "<leader>a", group = "AI", icon = { icon = '󱙺', color = 'azure' } },
            { "<leader>A", group = "Alternate", icon = { icon = '', color = 'cyan' } },
            { "<leader>b", group = "Browse", icon = { icon = '', color = 'yellow' } },
            { "<leader>c", group = "Code" },
            { "<leader>d", group = "Diff", icon = { icon = '', color = 'green' } },
            { "<leader>f", group = "Find" },
            { "<leader>h", group = "Hunk", icon = { icon = "", color = "cyan" } },
            { "<leader>p", group = "Prettify", icon = { icon = "󰭈", color = "yellow" } },
            { "<leader>s", group = "Search" },
            { "<leader>u", group = "UI" },
            { "<leader>w", group = "Session" },
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
