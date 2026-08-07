return {
    -- 参考: https://www.lazyvim.org/plugins/lsp#nvim-lspconfig
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
}
