return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    config = function()
      require("catppuccin").setup({
        -- add configuration here
	transparent_background = true,
	default_integrations = false,
	auto_integrations = false,
	integrations = {
	  which_key = false,
	},

	 
	custom_highlights = function(colors)
          return {
	      -- NOTE: 
	      -- catppuccin が、which-key に色を当てている。
	      -- @see https://github.com/catppuccin/nvim/blob/da33755d00e09bff2473978910168ff9ea5dc453/lua/catppuccin/groups/integrations/which_key.lua
	      --
	      -- 以下はオーバーライドできない模様
	      -- WhichKeyNormal = { bg = "none" },
	      
	      -- 以下はオーバーライド可能だった。
	      -- WhichKeyDesc = { fg = colors.blue },
	      
	      -- そこで :highlight WhichKeyNormal が、NormalFloat に link しているため、NormalFloat を上書き
	      -- @see https://github.com/catppuccin/nvim/blob/da33755d00e09bff2473978910168ff9ea5dc453/lua/catppuccin/groups/editor.lua#L40
	      -- vim.o.winblend を 0 に設定する方がよいかもしれない
	      NormalFloat = { bg = colors.none },
          }
        end,
      })
      vim.cmd.colorscheme "catppuccin-mocha"
    end,
  },
}
