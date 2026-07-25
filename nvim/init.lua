-- 基本的な設定
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.number = false

vim.opt.undofile = true
vim.opt.undodir = "/tmp/vim_undodir"

vim.opt.expandtab = true   -- タブキーでスペースに展開
vim.opt.shiftwidth = 4     -- インデント操作 (>>など) の幅を4に設定
vim.opt.tabstop = 4        -- タブ文字 (\t) の表示幅を4に設定
vim.opt.softtabstop = 4    -- Backspaceなどで削除する際の幅を4に設定
vim.opt.autoindent = true  -- 改行したときに前の行のインデントを引き継ぐ
vim.opt.smartindent = true -- 構文を考慮しインデントレベルを自動調整する
vim.opt.guicursor:append("t:ver25-blinkon0")

vim.opt.conceallevel = 2
vim.opt.clipboard:append({ "unnamedplus" })

-- clear statusline
vim.opt.laststatus = 0
vim.opt.statusline = "─"
vim.opt.fillchars:append({ stl = "─", stlnc = "─" })

-- diff
vim.opt.fillchars:append({ diff = ' ' })
vim.opt.diffopt:append("iwhite")

-- Ctrl-p/n でコマンド履歴のフィルタリングまで行う。
-- たとえば、:help としてこれらのキーを入力すると、help から始まる履歴だけ移動できる
vim.cmd("cnoremap <C-p> <Up>")
vim.cmd("cnoremap <C-n> <Down>")

-- 分割ウィンドウのキーマップを tmux と合わせる
vim.keymap.set('n', '<C-W>\\', '<Cmd>vsplit<CR>', { silent = true, desc = 'Vertical Split (custom)' })
vim.keymap.set('n', '<C-W>-', '<Cmd>split<CR>', { silent = true, desc = 'Horizontal Split (custom)' })
vim.keymap.set('n', '<C-W>x', '<C-W>q', { silent = true, desc = 'Quit a window (custom)' })

-- 現在のファイルのフルパスをコピー
vim.keymap.set('n', '<leader>y', ':let @+ = expand("%:.") . ":" . line(".")<CR>',
    { silent = true, desc = 'yank relative path with linenumber' }
)

-- 水平スクロール
vim.keymap.set("n", "zl", "zL", { desc = "Scroll half screen right" })
vim.keymap.set("n", "zh", "zH", { desc = "Scroll half screen left" })

-- 表示の切り替え
vim.keymap.set('n', '<leader>un', function()
    vim.opt.number = not vim.opt.number:get()
end, { desc = "Toggle line numbers" })
vim.keymap.set("n", "<leader>ur", "<cmd>nohlsearch|diffupdate|normal! <C-L><cr>", { desc = "Redraw Screen" })

-- ファイル書き込み前 (BufWritePre) に、末尾の空白を削除するコマンドを実行
local group = vim.api.nvim_create_augroup("TidyOnWrite", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    pattern = "*", -- すべてのファイルタイプに対して実行
    command = [[%s/\s\+$//e]],
})

-- LSP code action のキーマップを追加（デフォルトでは gra にマッピングされている）
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP Code Action' })

-- terminal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })
vim.keymap.set('t', '<C-[>', [[<C-\><C-n>]], { noremap = true })


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
