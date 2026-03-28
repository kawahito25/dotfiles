return {
  'stevearc/conform.nvim',
  opts = {
       formatters_by_ft = {
           javascript = { "prettierd", "eslint_d" },
           typescript = { "prettierd", "eslint_d" },
           javascriptreact = { "prettierd", "eslint_d" },
           typescriptreact = { "prettierd", "eslint_d" },
       },
       format_on_save = {
           lsp_format = "fallback",
           timeout_ms = 500,
       },
  },
}
