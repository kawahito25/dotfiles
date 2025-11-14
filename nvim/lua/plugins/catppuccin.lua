return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "latte",  
    },
    config = function()
      require("catppuccin").setup({
      })
      vim.cmd.colorscheme "catppuccin-mocha"
    end,
  },
}
