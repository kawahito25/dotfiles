vim.lsp.enable({ 'lua_ls', 'copilot' })

-- @see https://neovim.io/doc/user/lsp.html#lsp-attach
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        -- keymaps
        local function keymap(mode, lhs, rhs, opts)
            -- デフォルトのオプションを設定
            opts = opts or {}
            opts.noremap = opts.noremap ~= false
            opts.silent = opts.silent ~= false

            -- 実際のAPI呼び出し
            vim.api.nvim_buf_set_keymap(args.buf, mode, lhs, rhs, opts)
        end

        -- default keymappings are here: https://neovim.io/doc/user/lsp.html#lsp-defaults
        keymap('n', 'grd', '<cmd>lua vim.lsp.buf.definition()<CR>', { desc = "Goto Definition" })


        -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
        -- if client:supports_method('textDocument/completion') then
        -- Optional: trigger autocompletion on EVERY keypress. May be slow!
        -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
        -- client.server_capabilities.completionProvider.triggerCharacters = chars
        -- vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        -- end

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

vim.diagnostic.config({
    underline = false,
    virtual_text = {
        source = true,
        severity = vim.diagnostic.severity.ERROR, -- インラインメッセージは error に限定（ 他の serviry はnvim のデフォルトの keymap <C-w>d で、確認する）
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
    },
})
