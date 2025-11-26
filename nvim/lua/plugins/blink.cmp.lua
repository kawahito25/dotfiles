-- See Document: https://cmp.saghen.dev/
return {
    'saghen/blink.cmp',
    version = '*',
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
            },
            ghost_text = {
                enabled = true
            },
            menu = {
                draw = {
                    columns = {
                        { "kind_icon" },
                        { "label",      "label_description", gap = 1 },
                        { "source_name" }
                    },
                }
            },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            per_filetype = {
                markdown = { "snippets", "path" },
            },
        },
        keymap = {
            -- note: ctrl + e または Esc で補完を無視して現在のテキストを保持する
            ['<C-n>'] = { 'show', 'select_next', 'fallback' },
            ['<C-p>'] = { 'show', 'select_prev', 'fallback' },
            ['<Tab>'] = { 'select_next', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'fallback' },
            ['<CR>'] = {
                'accept',   -- 現在選択されている候補を決定して挿入
                'fallback', -- 候補がない場合や決定できない場合は通常のEnterキーの動作（改行）を行う
            },
        },
    },
}
