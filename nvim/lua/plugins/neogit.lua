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
        { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
    },
}
