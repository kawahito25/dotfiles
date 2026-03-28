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

vim.lsp.enable({ 'clangd', 'eslint', 'lua_ls', 'ruby_lsp', 'sorbet', 'syntax_tree', 'ts_ls', 'typos_lsp' })

-- 最も高い Severity の診断結果一つだけを抽出する共通関数
local function top_severity_only(_, _, diagnostics, _)
    -- diagnostics は severity_sort = true の設定により、既にSeverity順に並んでいる
    if #diagnostics == 0 then
        return {} -- 診断結果がなければ空のテーブルを返す
    end

    -- 最も高い Severity の診断結果（リストの最初の要素）のみを含むテーブルを返す
    return { diagnostics[1] }
end

vim.diagnostic.config({
    underline = false,
    severity_sort = true,
    virtual_text = {
        source = true,
        filter = top_severity_only,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
        filter = top_severity_only,
    },
    float = {
        border = "single",
    },
})
