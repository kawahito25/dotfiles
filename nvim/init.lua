-- 基本的な設定
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.number = false
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })
vim.o.exrc = true
vim.opt.cmdwinheight = 20
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

vim.keymap.del("n", "<C-w>d")
vim.keymap.set("n", "<C-w>u", function() vim.cmd("resize +15") end, { desc = "Increase window height" })
vim.keymap.set("n", "<C-w>d", function() vim.cmd("resize -15") end, { desc = "Decrease window height" })

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


local group = vim.api.nvim_create_augroup("TidyOnWrite", { clear = true })

-- ファイル書き込み前に、行末の空白と末尾の不要な空行を削除
vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    pattern = "*", -- すべてのファイルタイプに対して実行
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[keeppatterns %s/\s\+$//e]])             -- 行末の空白
        vim.cmd([[keeppatterns %s/\%(\$\n\s*\)\+\%$//e]]) -- ファイル末尾の空行
        vim.fn.setpos(".", save_cursor)
    end,
})

-- 全角スペースをハイライト
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufRead" }, {
    group = group,
    pattern = "*",
    callback = function()
        vim.fn.matchadd("ZenkakuSpace", "　")
    end,
})

-- LSP code action のキーマップを追加（デフォルトでは gra にマッピングされている）
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP Code Action' })

-- terminal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })
vim.keymap.set('t', '<C-[>', [[<C-\><C-n>]], { noremap = true })

-- my nav
vim.keymap.set("n", "<leader>ga", function()
    require("my_nav").handler()
end, { silent = true, desc = "My custom navigation" })

-- 外部でファイルが変更されたら自動読み込み
vim.o.autoread = true

-- Neovim にフォーカスが戻ったときに変更をチェック
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    pattern = "*",
    command = "if mode() != 'c' | checktime | endif",
})

-- インデント間の移動
local function move_same_indent(forward)
    local current_line = vim.fn.line('.')
    local current_indent = vim.fn.indent(current_line)
    local last_line = vim.fn.line('$')
    local step = forward and 1 or -1
    local target_line = current_line + step

    while target_line > 0 and target_line <= last_line do
        local line_content = vim.fn.getline(target_line)
        if vim.fn.match(line_content, '^%s*$') == -1 and vim.fn.indent(target_line) == current_indent then
            vim.fn.cursor(target_line, vim.fn.col('.'))
            break
        end
        target_line = target_line + step
    end
end
vim.keymap.set('n', '<Tab>', function() move_same_indent(true) end, { desc = 'Next line with same indent' })
vim.keymap.set('n', '<S-Tab>', function() move_same_indent(false) end, { desc = 'Prev line with same indent' })

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
