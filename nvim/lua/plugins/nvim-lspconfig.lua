return {
  -- 参考: https://www.lazyvim.org/plugins/lsp#nvim-lspconfig
  "neovim/nvim-lspconfig",
  -- LazyVim の LazyFile イベントを真似た @see  https://github.com/LazyVim/LazyVim/discussions/1583#discussion-5700903
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
}
