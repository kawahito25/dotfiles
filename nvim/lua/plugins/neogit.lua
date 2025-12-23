return {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
        "nvim-lua/plenary.nvim",  -- required
        "sindrets/diffview.nvim", -- optional - Diff integration
        "folke/snacks.nvim",      -- optional
    },
    cmd = "Neogit",
    opts = {
        disable_insert_on_commit = true,
        commit_editor = {
            kind = "tab",
            show_staged_diff = true,
            staged_diff_split_kind = "split",
            spell_check = false,
        },
    },
    keys = {
        { "<leader>gg", "<cmd>Neogit<cr>",                                               desc = "Open Neogit" },
        { "<leader>gc", function() require('neogit').open({ "commit" }) end,             desc = "Git Commit (Neogit)" },
        { "<leader>gl", function() require('neogit').action("log", "log_current")() end, desc = "Git Log (Neogit)" },
        {
            "<leader>gl",
            function()
                local region = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
                local selection = table.concat(region, "\n")

                if selection == "" then return end
                local action = require('neogit').action("log", "log_current", { "-S", selection })
                action()
            end,
            desc = "Git Log -S (Neogit)",
            mode = "v"
        },
    },
}
