return {
    "sindrets/diffview.nvim",
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
    keys = {
        {
            '<leader>di', -- 例: <leader>g + d でDiffviewを開閉
            function()
                if next(require("diffview.lib").views) == nil then
                    vim.cmd('DiffviewOpen')
                else
                    vim.cmd('DiffviewClose')
                end
            end,
            desc = 'Toggle Diffview window',
        },
        {
            '<leader>dh', -- 例: <leader>g + f でファイルリストにフォーカス
            function()
                if next(require("diffview.lib").views) == nil then
                    vim.cmd('DiffviewFileHistory')
                else
                    vim.cmd('DiffviewClose')
                end
            end,
            desc = 'DiffviewFileHistor',
        },
    }
}
