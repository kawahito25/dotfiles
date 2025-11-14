return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    config = function()
      require("catppuccin").setup({
        -- add configuration here
      })
      vim.cmd.colorscheme "catppuccin-mocha"
    end,
  },
}
