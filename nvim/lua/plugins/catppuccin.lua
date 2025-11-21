return {
    {
        "catppuccin/nvim",
        Cname = "catppuccin",
        lazy = false,
        config = function()
            require("catppuccin").setup({
                -- add configuration here
                transparent_background = true,
                float = {
                    transparent = true, -- enable transparent floating windows
                },
                integrations = {
                    -- which-key.nvim: https://github.com/folke/which-key.nvim/blob/main/lua/which-key/colors.lua
                    -- catpuuccin: https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/which_key.lua
                    which_key = true,

                    -- catppuccin: https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/gitsigns.lua
                    gitsigns = true,
                },
                custom_highlights = function(colors)
                    return {
                        FloatBorder = { fg = colors.surface2, bg = colors.none },
                    }
                end,
            })

            vim.cmd.colorscheme("catppuccin-mocha")

            require("lualine").setup({
                options = {
                    theme = "catppuccin",
                },
            })
        end,
    },
}
