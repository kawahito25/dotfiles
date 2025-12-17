return {
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
}
