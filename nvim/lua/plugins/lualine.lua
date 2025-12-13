local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed
        }
    end
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
        options = {
            theme = "catppuccin",
            disabled_filetypes = { statusline = { "snacks_dashboard" }, },
        },
        sections = {
            lualine_a = {
                'mode',
                {
                    'searchcount',
                    maxcount = 999,
                    timeout = 500,
                },
            },
            lualine_b = {
                { 'b:gitsigns_head', icon = '' },
                { 'diff', source = diff_source },
            },
            lualine_c = {
                {
                    'filename',
                    path = 4,
                }
            },
        },
    }
}
