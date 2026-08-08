return {
    "gbprod/yanky.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    dependencies = {
        { "kkharji/sqlite.lua" }
    },
    opts = {
        ring = { storage = "sqlite" },
        system_clipboard = {
            sync_with_ring = false, -- zellij で 別アプリに移動した際に、FocusGained / FocusLost イベントが発火しないため、true にしても動作しない。
        },
    },
    keys = {
        {
            "<leader>sy",
            function() Snacks.picker.yanky({ layout = { fullscreen = false }, }) end,
            mode = { "n", "x" },
            desc = "Open Yank History",
        },
        { "y",  "<Plug>(YankyYank)",            mode = { "n", "x" },                  desc = "Yank Text" },
        { "p",  "<Plug>(YankyPutAfter)",        mode = { "n", "x" },                  desc = "Put Text After Cursor" },
        { "P",  "<Plug>(YankyPutBefore)",       mode = { "n", "x" },                  desc = "Put Text Before Cursor" },
        { "=p", "<Plug>(YankyPutAfterFilter)",  desc = "Put After Applying a Filter" },
        { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put Before Applying a Filter" },
    }
}
