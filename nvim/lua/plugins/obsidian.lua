return {
    "obsidian-nvim/obsidian.nvim",
    version = "*",                                                  -- recommended, use latest release instead of latest commit
    dependencies = { "MeanderingProgrammer/render-markdown.nvim" }, -- 指定しないと挙動が怪しい
    ft = "markdown",
    opts = {
        checkbox = {
            order = { " ", "x" },
        },
        legacy_commands = false,
        workspaces = {
            {
                name = "personal",
                path = "~/obsidian_vaults/personal",
            },
        },
    },
    keys = {
        { "<leader>nn", "<cmd>Obsidian new<cr>",          desc = "New Obsidian note", mode = "n" },
        { "<leader>nw", "<cmd>Obsidian search word<cr>",  desc = "Search Word",       mode = "n" },
        { "<leader>nf", "<cmd>Obsidian quick_switch<cr>", desc = "Find Files",        mode = "n" },
    },
}
