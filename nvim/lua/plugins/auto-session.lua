return {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
        auto_restore = false,
        git_use_branch_name = true,
        bypass_save_filetypes = { "snacks_dashboard" },
        -- Save quickfix list and open it when restoring the session
        save_extra_cmds = {
            function()
                local qflist = vim.fn.getqflist()
                -- return nil to clear any old qflist
                if #qflist == 0 then
                    return nil
                end
                local qfinfo = vim.fn.getqflist({ title = 1 })

                for _, entry in ipairs(qflist) do
                    -- use filename instead of bufnr so it can be reloaded
                    entry.filename = vim.api.nvim_buf_get_name(entry.bufnr)
                    entry.bufnr = nil
                end

                local setqflist = "call setqflist(" .. vim.fn.string(qflist) .. ")"
                local setqfinfo = 'call setqflist([], "a", ' .. vim.fn.string(qfinfo) .. ")"
                return { setqflist, setqfinfo }
            end,
        },
        session_lens = {
            picker = "snacks",
            picker_opts = { preset = "default" },
            mappings = {},
        },
    },
    keys = {
        { "<leader>w",  "",                             desc = "+Session" },
        { "<leader>ws", "<cmd>AutoSession search<CR>",  desc = "Session search" },
        { "<leader>wr", "<cmd>AutoSession restore<CR>", desc = "Session restore" },
    }
}
