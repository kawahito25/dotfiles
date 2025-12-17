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
    }
}
