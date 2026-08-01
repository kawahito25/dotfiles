-- See Document: https://cmp.saghen.dev/
return {
    'saghen/blink.cmp',
    version = '*',
    dependencies = {
        { 'disrupted/blink-cmp-conventional-commits' },
        { "marcoSven/blink-cmp-yanky" },
        {
            'L3MON4D3/LuaSnip',
            version = 'v2.*',
            dependencies = {
                {
                    "rafamadriz/friendly-snippets",
                    config = function()
                        require("luasnip.loaders.from_vscode").lazy_load()
                    end,
                },
            }
        },
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
        snippets = { preset = 'luasnip' },
        sources = {
            default = { "lsp", "path", "snippets", "buffer", 'conventional_commits', 'omni', 'yank' },
            providers = {
                conventional_commits = {
                    name = "conventional_commits",
                    module = "blink-cmp-conventional-commits",
                    enabled = function()
                        return vim.bo.filetype == 'gitcommit'
                    end,
                    opts = {},
                },
                yank = {
                    name = "yank",
                    module = "blink-yanky",
                    opts = { kind_icon = '󰅍', onlyCurrentFiletype = true },
                    score_offset = -2,
                }
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
