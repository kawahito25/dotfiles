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
            focus = "input",
            layout = { fullscreen = true },
            matcher = { frecency = true },
            sources = {
                select = { layout = { preset = 'select', fullscreen = false } },
                explorer = { auto_close = true, hidden = true, ignored = true, layout = { fullscreen = false }, },
                recent = {
                    transform = function(item)
                        if vim.fn.isdirectory(item.file) == 1 then return false end -- ディレクトリを検索対象から除外
                    end

                },
                smart = {
                    transform = function(item, ctx)
                        -- smart のデフォルトの transform "unique_file" の実装をコピペ
                        -- @see https://github.com/folke/snacks.nvim/blob/fe7cfe9800a182274d0f868a74b7263b8c0c020b/lua/snacks/picker/transform.lua#L5-L12
                        ctx.meta.done = ctx.meta.done or {}
                        local path = Snacks.picker.util.path(item)
                        if not path or ctx.meta.done[path] then
                            return false
                        end
                        ctx.meta.done[path] = true

                        if vim.fn.isdirectory(item.file) == 1 then return false end -- ディレクトリを検索対象から除外
                    end
                },
            },
            win = {
                input = {
                    keys = {
                        ["<C-Space>"] = { "select_all", mode = { "n", "i" } },
                        ["<a-d>"] = {
                            "toggle_search_dir",
                            mode = { "n", "i" },
                        },
                        ['<c-/>'] = { 'choose_history', mode = { 'i', 'n' } },
                        ["<C-j>"] = { "history_forward", mode = { "i", "n" } },
                        ["<C-k>"] = { "history_back", mode = { "i", "n" } },
                    },
                },
                list = {
                    keys = {
                        ["<C-space>"] = { "select_all", mode = { "n", "i" } },
                        ["<a-d>"] = {
                            "toggle_search_dir",
                            mode = { "n", "i" },
                        },
                        ['<c-/>'] = { 'choose_history', mode = { 'i', 'n' } },
                    }
                },
            },
            actions = {
                toggle_search_dir = function(p)
                    local all_projects = "~/code/github.com"
                    local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or ".")
                    local current = p:cwd()
                    p:set_cwd(current == cwd and all_projects or cwd)
                    p:find()
                end,
                -- @see https://github.com/folke/snacks.nvim/discussions/2374#discussioncomment-14817479
                choose_history = function(picker)
                    local history = picker.history.kv.data
                    local items = {}
                    for i = 1, #history do
                        local hist = history[#history + 1 - i]
                        table.insert(items, {
                            idx = i,
                            pattern = hist.pattern,
                            search = hist.search,
                            live = hist.live,
                            text = hist.search .. ' ' .. hist.pattern,
                        })
                    end
                    Snacks.picker.pick {
                        title = 'Picker history',
                        items = items,
                        main = { current = true }, -- NOTE: Prevent closing the parent picker
                        layout = { preset = 'select', fullscreen = false },
                        supports_live = false,
                        transform = function(item)
                            return not (item.pattern == '' and item.search == '')
                        end,
                        format = function(item)
                            local ico = { live = picker.opts.icons.ui.live, prompt = picker.opts.prompt }
                            local part1 = item.live and item.pattern or item.search
                            local part2 = item.live and item.search or item.pattern
                            --
                            local text = {}
                            table.insert(text, { item.live and ico.live or '  ', 'Special' })
                            table.insert(text, { ' ' })
                            table.insert(text, { part1, 'SnacksPickerInputSearch' })
                            if part1 ~= '' and part2 ~= '' then
                                table.insert(text, { ' ' })
                                table.insert(text, { ico.prompt, 'SnacksPickerPrompt' })
                            end
                            table.insert(text, { part2 })
                            return text
                        end,
                        confirm = function(history_picker, item)
                            local mode = vim.fn.mode()
                            picker.opts.live = item.live
                            picker.input:set(item.pattern, item.search)
                            history_picker:close()
                            if mode == 'i' then
                                -- stylua: ignore
                                vim.schedule(function() vim.cmd 'startinsert!' end)
                            end
                        end,
                    }
                end,
            },
            toggles = {
                -- follow = "f",
                -- ignored = "i",
                -- modified = "m",
                hidden = "󰘓",
                regex = "󰑑",
                search_dir = '',
            },
        },
        scroll = { enabled = true },
        notifier = { enabled = true },
    },
    keys = {
        -- Top Pickers & Explorer
        {
            "<leader>/",
            function() Snacks.picker.grep({ hidden = true, args = { '-P' } }) end,
            desc = "Grep",
        },
        {
            "<leader>;",
            function() Snacks.picker.git_status({ layout = "vscode" }) end,
            desc = "Visual selection or word",
            mode = { "n", "x" },
        },
        { "<leader><space>", function() Snacks.picker.smart({ hidden = true }) end,                       desc = "Smart Find Files" },
        { "<leader>,",       function() Snacks.picker.buffers({ layout = "vscode", current = true }) end, desc = "Buffers" },
        { "<leader>:",       function() Snacks.picker.command_history() end,                              desc = "Command History" },
        { "<leader>.",       function() Snacks.picker.resume() end,                                       desc = "Resume" },
        { "<leader>e",       function() Snacks.explorer() end,                                            desc = "File Explorer" },
        -- find
        {
            "<leader>fc",
            function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
            desc = "Find Config File",
        },
        { "<leader>ff", function() Snacks.picker.files({ hidden = true }) end, desc = "Find Files" },
        { "<leader>fg", function() Snacks.picker.git_files() end,              desc = "Find Git Files" },
        { "<leader>fn", function() Snacks.picker.notifications() end,          desc = "Notification History" },
        {
            "<leader>fp",
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
        { "<leader>fr", function() Snacks.picker.recent() end,                      desc = "Recent" },
        -- search
        { '<leader>s"', function() Snacks.picker.registers() end,                   desc = "Registers" },
        { '<leader>s/', function() Snacks.picker.search_history() end,              desc = "Search History" },
        { "<leader>sa", function() Snacks.picker.autocmds() end,                    desc = "Autocmds" },
        { "<leader>sb", function() Snacks.picker.lines() end,                       desc = "Buffer Lines" },
        { "<leader>sC", function() Snacks.picker.commands() end,                    desc = "Commands" },
        { "<leader>sd", function() Snacks.picker.diagnostics() end,                 desc = "Diagnostics" },
        { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end,          desc = "Buffer Diagnostics" },
        { "<leader>sh", function() Snacks.picker.help() end,                        desc = "Help Pages" },
        { "<leader>sH", function() Snacks.picker.highlights() end,                  desc = "Highlights" },
        { "<leader>si", function() Snacks.picker.icons() end,                       desc = "Icons" },
        { "<leader>sj", function() Snacks.picker.jumps() end,                       desc = "Jumps" },
        { "<leader>sk", function() Snacks.picker.keymaps() end,                     desc = "Keymaps" },
        { "<leader>sl", function() Snacks.picker.loclist() end,                     desc = "Location List" },
        { "<leader>sm", function() Snacks.picker.marks() end,                       desc = "Marks" },
        { "<leader>sn", function() Snacks.picker.notifications() end,               desc = "Notification History" },
        { "<leader>sM", function() Snacks.picker.man() end,                         desc = "Man Pages" },
        { "<leader>sp", function() Snacks.picker.lazy() end,                        desc = "Search for Plugin Spec" },
        { "<leader>sq", function() Snacks.picker.qflist({ layout = "bottom" }) end, desc = "Quickfix List" },
        { "<leader>su", function() Snacks.picker.undo() end,                        desc = "Undo History" },
        {
            '<leader>sc',
            function()
                Snacks.picker.git_diff({
                    layout = {
                        layout = {
                            box = "vertical",
                            width = 0.8,
                            height = 0.8,
                            border = "rounded",
                            { win = "input",  height = 1,   border = "bottom" },
                            { win = "list",   height = 0.3, border = "bottom" },
                            { win = "preview" },
                        },
                    },
                })
            end,
            desc = 'Search Changes',
        },
        -- LSP
        { "gd",         function() Snacks.picker.lsp_definitions() end,                 desc = "Goto Definition" },
        { "gD",         function() Snacks.picker.lsp_declarations() end,                desc = "Goto Declaration" },
        { "gr",         function() Snacks.picker.lsp_references() end,                  nowait = true,                  desc = "References" },
        { "gI",         function() Snacks.picker.lsp_implementations() end,             desc = "Goto Implementation" },
        { "gy",         function() Snacks.picker.lsp_type_definitions() end,            desc = "Goto T[y]pe Definition" },
        { "gai",        function() Snacks.picker.lsp_incoming_calls() end,              desc = "C[a]lls Incoming" },
        { "gao",        function() Snacks.picker.lsp_outgoing_calls() end,              desc = "C[a]lls Outgoing" },
        { "<leader>ss", function() Snacks.picker.lsp_symbols({ layout = "right" }) end, desc = "LSP Symbols" },
        -- open
        {
            "<leader>ogf",
            function()
                Snacks.gitbrowse({
                    branch = (function()
                        local output = vim.fn.system("git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null")

                        if output and output ~= "" then
                            return output
                                :gsub("^refs/remotes/origin/", "")
                                :gsub("[\r\n]$", "")
                        end

                        return "main"
                    end)()
                })
            end,
            desc = "Open file in GitHub",
            mode = { "n", "v" }
        },
        {
            "<leader>ogw",
            function()
                local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h");
                local output = vim.fn.system("git -C " .. dir .. " remote -v");
                local first_line = vim.split(output, "\n")[1];
                local remote = first_line:match("%S+%s+(%S+)%s+%(%S+%)");
                local org = remote:match("[:/]([^/:]+)/[^/%. ]+%.git$")
                local search_url = string.format("https://github.com/search?q=org:%s+%s", org, vim.fn.expand("<cword>"))
                vim.ui.open(search_url)
            end,
            desc = "Search word in Github organization",
            mode = { "n", "v" }
        },
    },
}
