return {
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        dependencies = {
            "copilotlsp-nvim/copilot-lsp",
        },
        opts = {
            -- blink-cmp-copilot の README を参照
            suggestion = { enabled = false },
            panel = { enabled = false },
            copilot_node_command = vim.fn.expand("$HOME") .. "/.asdf/installs/nodejs/25.1.0/bin/node", -- Node.js version must be > 22
        }
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim", branch = "master" },
        },
        build = "make tiktoken",
        cmd = "CopilotChat", -- lazy-load on a command
        opts = {
            model = 'gpt-4.1',
            mappings = {
                reset = {
                    normal = "<leader>ur",
                    insert = "<leader>ur",
                },
            },
        },
        keys = {
            {
                "<leader>ar",
                function()
                    require("CopilotChat").ask(
                        "バグの可能性がないか、よりシンプルで可読性の高いコードに変更できないか、という観点で日本語でコードレビューして。", {
                            model = "gpt-4.1",
                            sticky = { "#buffer", "#gitdiff:staged" }
                        })
                end,
                desc = "Copilot Review"
            },
        }
    },
}
