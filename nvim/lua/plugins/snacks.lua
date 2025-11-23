return {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
        dashboard = {
            enabled = true,
            sections = {
                { section = "header" },
                { section = "startup", padding = 1.0 },
                { section = "keys", padding = 1.0 },
                { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1.0 },
            },
        },
        indent = { enabled = true, animate = { enabled = false } },
        picker = {
            enabled = true,
            focus = "list",
            matcher = {
                frecency = true,
            },
        },
        scroll = { enabled = true },
        notifier = { enabled = true },
    },
    keys = {
        -- Top Pickers & Explorer
        { "<leader><space>", function() Snacks.picker.smart() end,                       desc = "Smart Find Files" },
        { "<leader>,",       function() Snacks.picker.buffers() end,                     desc = "Buffers" },
        { "<leader>/",       function() Snacks.picker.grep() end,                        desc = "Grep" },
        { "<leader>:",       function() Snacks.picker.command_history() end,             desc = "Command History" },
        { "<leader>m",       function() Snacks.picker.files({ cwd = "~/dev_note" }) end, desc = "Dev Note" },
        { "<leader>n",       function() Snacks.picker.notifications() end,               desc = "Notification History" },
        { "<leader>e",       function() Snacks.explorer() end,                           desc = "File Explorer" },
        {
            "<leader>g",
            function()
                Snacks.picker({
                    finder = "proc",
                    cmd = "ghq",
                    args = { "list", "--full-path" },
                    transform = function(item)
                        item.file = item.text
                        item.dir = true
                    end,
                    confirm = function(picker, item)
                        picker:close()
                        vim.cmd("cd " .. item.text)
                        Snacks.dashboard.open()
                    end,
                })
            end,
            desc = "ghq projects",
        },
        -- find
        { "<leader>fb", function() Snacks.picker.buffers() end,   desc = "Buffers" },
        {
            "<leader>fc",
            function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
            desc = "Find Config File",
        },
        { "<leader>ff", function() Snacks.picker.files() end,     desc = "Find Files" },
        { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
        { "<leader>fp", function() Snacks.picker.projects() end,  desc = "Projects" },
        { "<leader>fr", function() Snacks.picker.recent() end,    desc = "Recent" },
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Create some toggle mappings
                Snacks.toggle.indent():map("<leader>ug")
                Snacks.toggle.dim():map("<leader>uD")
            end,
        })
    end,
}
