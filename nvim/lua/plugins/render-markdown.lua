return {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    opts = {
        enabled = false,
        anti_conceal = { enabled = false },
    },
    keys = {
        {
            "<leader>um",
            function()
                require('render-markdown').buf_toggle()
            end,
            desc = "Toggle Markdown Preview",
        },
    },
}
