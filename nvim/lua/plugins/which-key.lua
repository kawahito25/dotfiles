return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        -- presets: https://github.com/folke/which-key.nvim/blob/main/lua/which-key/presets.lua
        win = {
            width = math.huge,
            height = { min = 4, max = 25 },
            col = 0,
            row = -1,
            border = "rounded",
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
