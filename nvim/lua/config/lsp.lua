vim.lsp.config('sorbet', {
    on_attach = function(client, bufnr)
        client.server_capabilities.documentSymbolProvider = false
    end,
})
vim.lsp.config('ts_ls', {
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
})

vim.lsp.enable({
    'clangd',
    'eslint',
    'gopls',
    'lua_ls',
    'ruby_lsp',
    'sorbet',
    'syntax_tree',
    'ts_ls',
    'typos_lsp',
})

-- ==============================================================================
-- Git Conflict & LSP Diagnostics Integration
-- 目的: Gitコンフリクト発生時にLSPの診断解析は維持しつつ、
--       Virtual TextやSigns、Underlineなどの「視覚的ノイズ」のみを一時的に非表示にする。
-- ==============================================================================

-- 1. 診断の表示フィルター関数
-- 通常時は上位1件のみを表示し、それ以外を間引く。
local function top_severity_only(_, bufnr, diagnostics, _)
    -- コンフリクト中の場合はすべての診断を空にして視覚的ノイズを非表示にする
    if vim.b[bufnr] and vim.b[bufnr].is_git_conflict then
        return {}
    end

    if #diagnostics == 0 then
        return {}
    end

    -- 上位（最も重要度が高い）1件のみを返す
    return { diagnostics[1] }
end

-- 2. 基本的な診断設定の定義
local diagnostic_config = {
    underline = false,
    severity_sort = true,
    virtual_text = {
        source = true,
        filter = top_severity_only,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN]  = "",
            [vim.diagnostic.severity.INFO]  = "",
            [vim.diagnostic.severity.HINT]  = "",
        },
        filter = top_severity_only,
    },
    float = {
        border = "single",
    },
}

-- グローバルに設定を適用
vim.diagnostic.config(diagnostic_config)

-- 3. LSP名前空間ごとの表示・非表示を制御するヘルパー関数
local function toggle_lsp_diagnostics(bufnr, hide)
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    for _, client in ipairs(clients) do
        -- LSPクライアントごとに固有の名前空間を取得して個別に制御する
        local ns = vim.lsp.diagnostic.get_namespace(client.id)
        if hide then
            vim.diagnostic.hide(ns, bufnr)
        else
            vim.diagnostic.show(ns, bufnr)
        end
    end
end

-- 4. 自動コマンド（Autocommands）によるイベント連動設定
local augroup = vim.api.nvim_create_augroup("GitConflictLspIntegration", { clear = true })

-- コンフリクト検出時: バッファローカルフラグを立てて視覚的ノイズを即座に隠す
vim.api.nvim_create_autocmd("User", {
    group = augroup,
    pattern = "GitConflictDetected",
    callback = function(ev)
        local bufnr = ev.buf
        if bufnr and bufnr ~= 0 then
            vim.b[bufnr].is_git_conflict = true
            toggle_lsp_diagnostics(bufnr, true)
        end
    end,
})

-- コンフリクト解消時: フラグを降ろして診断を再表示する
vim.api.nvim_create_autocmd("User", {
    group = augroup,
    pattern = "GitConflictResolved",
    callback = function(ev)
        local bufnr = ev.buf
        if bufnr and bufnr ~= 0 then
            vim.b[bufnr].is_git_conflict = false
            toggle_lsp_diagnostics(bufnr, false)
        end
    end,
})

-- 診断更新ガード: LSPサーバーが非同期で診断を再送して上書きした際、
-- コンフリクト中であれば強制的に再非表示化し続ける
vim.api.nvim_create_autocmd("DiagnosticChanged", {
    group = augroup,
    callback = function(ev)
        local bufnr = ev.buf
        if bufnr and vim.b[bufnr] and vim.b[bufnr].is_git_conflict then
            toggle_lsp_diagnostics(bufnr, true)
        end
    end,
})
