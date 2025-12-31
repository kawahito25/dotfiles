vim.lsp.config('sorbet', {
    on_attach = function(client, bufnr)
        client.server_capabilities.documentSymbolProvider = false
    end,
})

vim.lsp.enable({ 'clangd', 'lua_ls', 'ruby_lsp', 'sorbet', 'syntax_tree', 'ts_ls', 'typos_lsp' })

-- @see https://neovim.io/doc/user/lsp.html#lsp-attach
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        -- Auto-format ("lint") on save.
        -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
    end,
})

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
