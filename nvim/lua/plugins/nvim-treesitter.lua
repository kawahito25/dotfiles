return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = "main",
        build = ":TSUpdate",
        highlight = { enable = true },
        fold = { enable = true },
        dependencies = {
            "RRethy/nvim-treesitter-endwise",
        },
        opts = function(_, opts)
            opts.endwise = {
                enable = true
            }
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        event = "VeryLazy",
    },
}
