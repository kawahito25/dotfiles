return {
    "MeanderingProgrammer/render-markdown.nvim",
    -- コメントアウト理由: nvim コマンドの引数としてマークダウンファイルを渡した際に、TODOリストの右側の文字が見切れる現象が発生したため
    -- ft = "markdown",
    -- event = "VeryLazy"
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    opts = {},
}
