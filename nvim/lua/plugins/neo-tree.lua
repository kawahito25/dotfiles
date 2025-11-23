if true then return {} end

return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false,                      -- neo-tree will lazily load itself
    opts = {
        filesystem = {
            filtered_items = {
                visible = false,
                show_hidden_count = false,
                hide_dotfiles = false,
                hide_gitignored = false,
                hide_ignored = false,
                hide_by_name = {
                    ".git",
                },
            },
        },
    },
}
