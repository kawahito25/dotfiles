-- See Document: https://cmp.saghen.dev/
return {
    'saghen/blink.cmp',
    version = '*',
    dependencies = {
        { "giuxtaposition/blink-cmp-copilot" },
        { 'disrupted/blink-cmp-conventional-commits' },
    },
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
                window = { border = "rounded" },
            },
            ghost_text = { enabled = true },
            menu = {
                border = "rounded",
                draw = {
                    columns = {
                        { "kind_icon" },
                        { "label",      "label_description", gap = 1 },
                        { "source_name" }
                    },
                }
            },
            list = {
                selection = { preselect = false }
            }
        },
        cmdline = {
            enabled = true,
            keymap = { preset = 'inherit' },
            completion = {
                list = { selection = { preselect = false } },
                menu = { auto_show = true },
            }
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer", "copilot", 'conventional_commits', 'omni' },
            providers = {
                copilot = {
                    name = "copilot",
                    module = "blink-cmp-copilot",
                    score_offset = 100,
                    async = true,
                },
                conventional_commits = {
                    name = "conventional_commits",
                    module = "blink-cmp-conventional-commits",
                    enabled = function()
                        return vim.bo.filetype == 'gitcommit'
                    end,
                    opts = {},
                },
            },
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
