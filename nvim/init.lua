-- 基本的な設定
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

vim.opt.undofile = true
vim.opt.undodir = "/tmp/vim_undodir"

vim.opt.expandtab = true   -- タブキーでスペースに展開
vim.opt.shiftwidth = 4     -- インデント操作 (>>など) の幅を4に設定
vim.opt.tabstop = 4        -- タブ文字 (\t) の表示幅を4に設定
vim.opt.softtabstop = 4    -- Backspaceなどで削除する際の幅を4に設定
vim.opt.autoindent = true  -- 改行したときに前の行のインデントを引き継ぐ
vim.opt.smartindent = true -- 構文を考慮しインデントレベルを自動調整する

vim.opt.conceallevel = 2

-- Ctrl-p/n でコマンド履歴のフィルタリングまで行う。
-- たとえば、:help としてこれらのキーを入力すると、help から始まる履歴だけ移動できる
vim.cmd("cnoremap <C-p> <Up>")
vim.cmd("cnoremap <C-n> <Down>")

require("config.lazy")
require("config.lsp")

-- fill gap between terminal and neovim --
-- @see https://github.com/neovim/neovim/issues/16572#issuecomment-1954420136
vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
    callback = function()
        local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
        if normal.bg then io.write(string.format("\027]11;#%06x\027\\", normal.bg)) end
    end,
})
vim.api.nvim_create_autocmd("UILeave", {
    callback = function() io.write("\027]111\027\\") end,
})
-- end --
