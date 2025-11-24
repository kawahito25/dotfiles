return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = "main",
        build = ":TSUpdate",
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        event = "VeryLazy",
    }
}
