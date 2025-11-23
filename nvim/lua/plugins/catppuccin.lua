return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
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

                snacks = {
                    enabled = true,
                    indent_scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
                },
                render_markdown = true,
                blink_cmp = { style = 'bordered' },
            },
            custom_highlights = function(colors)
                return {
                    FloatBorder = { fg = colors.surface2, bg = colors.none },

                    -- @override https://github.com/hat0uma/csvview.nvim/blob/688bcc7437b577de000f71a2d406271c79e2a545/lua/csvview/config.lua#L278-L287
                    CsvViewCol1 = { fg = colors.maroon },
                    CsvViewCol2 = { fg = colors.peach },
                    CsvViewCol3 = { fg = colors.yellow },
                    CsvViewCol4 = { fg = colors.green },
                    CsvViewCol5 = { fg = colors.teal },
                    CsvViewCol6 = { fg = colors.sapphire },
                    CsvViewCol7 = { fg = colors.blue },
                    CsvViewCol8 = { fg = colors.mauve }
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
}
