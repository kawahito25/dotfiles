return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
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
            lsp_trouble = true,
            blink_cmp = { style = 'bordered' },
            ufo = true,
            treesitter_context = true,
            neogit = true,
        },
        custom_highlights = function(colors)
            local u = require("catppuccin.utils.colors")

            return {
                FloatBorder              = { fg = colors.surface2, bg = colors.none },
                Folded                   = { fg = colors.text, bg = colors.surface0 },

                -- @override https://github.com/hat0uma/csvview.nvim/blob/688bcc7437b577de000f71a2d406271c79e2a545/lua/csvview/config.lua#L278-L287
                CsvViewCol1              = { fg = colors.maroon },
                CsvViewCol2              = { fg = colors.peach },
                CsvViewCol3              = { fg = colors.yellow },
                CsvViewCol4              = { fg = colors.green },
                CsvViewCol5              = { fg = colors.teal },
                CsvViewCol6              = { fg = colors.sapphire },
                CsvViewCol7              = { fg = colors.blue },
                CsvViewCol8              = { fg = colors.mauve },

                -- andymass/vim-matchup
                MatchParen               = {
                    bg = colors.none,
                    fg = colors.peach,
                    underline = true,
                    bold = true,
                },

                -- Snacks indent
                SnacksIndent             = { fg = colors.surface2 },

                -- nvim-bqf
                BqfPreviewBorder         = { fg = colors.blue },

                -- git-conflict
                GitConflictCurrent       = { bg = u.darken(colors.green, 0.15, colors.base) },
                GitConflictCurrentLabel  = { bg = colors.surface1, fg = colors.green, bold = true },
                GitConflictAncestor      = { bg = u.darken(colors.peach, 0.12, colors.base) },
                GitConflictAncestorLabel = { bg = colors.surface1, fg = colors.peach, bold = true },
                GitConflictIncoming      = { bg = u.darken(colors.blue, 0.15, colors.base) },
                GitConflictIncomingLabel = { bg = colors.surface1, fg = colors.blue, bold = true },
                GitConflictDelimiter     = { fg = colors.surface2, bold = true },
            }
        end,
    },
    config = function(_, opts)
        require("catppuccin").setup(opts)
        vim.cmd.colorscheme("catppuccin-mocha")
    end,
    specs = {
        {
            "akinsho/bufferline.nvim",
            optional = true,
            opts = function(_, opts)
                if (vim.g.colors_name or ""):find("catppuccin") then
                    opts.highlights = require("catppuccin.special.bufferline").get_theme()
                end
            end,
        },
    },
}
