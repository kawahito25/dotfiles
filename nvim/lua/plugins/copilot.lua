if true then return {} end;

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
        ft = "gitcommit",
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
                "<leader>ac",
                function()
                    local bufnr = vim.api.nvim_get_current_buf()
                    local chat = require("CopilotChat")
                    chat.ask(
                        "Write a Conventional Commit message in English. No chatter. Body max 3 lines, or omit if simple.",
                        {
                            model = "gpt-4.1",
                            sticky = { "#gitdiff:staged" },
                            callback = function(response)
                                vim.schedule(function()
                                    local lines = vim.split(response.content, "\n")
                                    if #lines > 0 and lines[1]:match("^%s*$") then
                                        table.remove(lines, 1)
                                    end
                                    vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, lines)
                                    chat.close()
                                end)
                            end,
                            window = {
                                layout = 'float',
                                width = 80,
                                height = 30,
                                border = 'rounded',
                            },
                        })
                end,
                ft = 'gitcommit',
                desc = "Copilot commit message"
            }
        },
    },
}
