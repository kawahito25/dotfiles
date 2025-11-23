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
            preset = 'super-tab',
            ["<Tab>"] = { -- @override super-tab
                function(cmp)
                    if cmp.snippet_active() then
                        return cmp.accept()
                    else
                        return cmp.select_and_accept()
                    end
                end,
                "snippet_forward",
                function() -- sidekick next edit suggestion
                    return require("sidekick").nes_jump_or_apply()
                end,
                -- function() -- if you are using Neovim's native inline completions
                --     return vim.lsp.inline_completion.get()
                -- end,
                "fallback",
            },
        },
    },
}
