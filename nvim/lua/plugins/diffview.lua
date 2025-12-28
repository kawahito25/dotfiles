return {
    "sindrets/diffview.nvim",
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
    keys = {
        {
            '<leader>gd',
            function()
                if next(require("diffview.lib").views) == nil then
                    vim.cmd('DiffviewOpen')
                else
                    vim.cmd('DiffviewClose')
                end
            end,
            desc = 'Git diff (DiffviewOpen)',
        },
        {
            '<leader>gf',
            function()
                if next(require("diffview.lib").views) == nil then
                    vim.cmd('DiffviewFileHistory %')
                else
                    vim.cmd('DiffviewClose')
                end
            end,
            desc = 'Git diff (DiffviewFileHistory)',
        },
    }
}
