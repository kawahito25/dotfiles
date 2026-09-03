local M = {}

local irregular_suffixes = {
    { pattern = "people$", replace = "person" },
}

local function singularize(table_name)
    for _, rule in ipairs(irregular_suffixes) do
        if table_name:match(rule.pattern) then
            return table_name:gsub(rule.pattern, rule.replace)
        end
    end

    local ok, result = pcall(function()
        return vim.api.nvim_eval(string.format("g:projectionist_transformations.singular('%s', {})", table_name))
    end)

    if ok and type(result) == "string" and result ~= "" then
        return result
    end

    if table_name:match("ies$") then return table_name:gsub("ies$", "y") end
    return table_name:gsub("s$", "")
end

M.patterns = {
    function(filepath, root)
        if (vim.bo.filetype == "ruby" or vim.bo.filetype == "eruby") and filepath:match("app/models/") then
            local schema_path = root .. "/db/schema.rb"
            if vim.fn.filereadable(schema_path) == 1 then
                local model_name = vim.fn.expand("%:t:r"):lower()
                local table_name = model_name .. "s"

                vim.cmd("edit " .. schema_path)
                vim.fn.cursor(1, 1)

                local pattern = [[create_table\s\+["']\zs]] .. table_name .. [=[["']]=]
                vim.fn.search(pattern, 'w')
            end
            return true
        end
    end,

    function(filepath, root)
        if filepath:match("db/schema%.rb$") then
            local line_num = vim.fn.search('create_table', 'bcnW')
            if line_num == 0 then return true end

            local line = vim.fn.getline(line_num)
            local table_name = line:match('create_table%s+["\']([^"\']+)["\']')
            if not table_name then return true end

            local model_name = singularize(table_name)
            local model_path = root .. "/app/models/" .. model_name .. ".rb"

            if vim.fn.filereadable(model_path) == 1 then
                vim.cmd("edit " .. model_path)
            end
            return true
        end
    end,

    function(filepath, _)
        local controller_path = filepath:match("app/controllers/(.+)_controller%.rb")
        if controller_path then
            local cmd = { "bundle", "exec", "rails", "routes", "-c", controller_path }

            vim.system(cmd, { text = true }, function(obj)
                if obj.code ~= 0 then
                    vim.schedule(function()
                        vim.notify("Failed to execute rails routes", vim.log.levels.ERROR)
                    end)
                    return
                end

                local lines = vim.split(obj.stdout, "\n", { trimempty = true })
                if #lines == 0 then
                    table.insert(lines, "No routes found for controller: " .. controller_path)
                end

                vim.schedule(function()
                    local buf = vim.api.nvim_create_buf(false, true)
                    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

                    vim.bo[buf].modifiable = false
                    vim.bo[buf].filetype = "railtmux"

                    vim.cmd("split")
                    local win = vim.api.nvim_get_current_win()
                    vim.api.nvim_win_set_buf(win, buf)

                    local target_height = math.min(math.max(#lines, 4), 15)
                    vim.api.nvim_win_set_height(win, target_height)
                end)
            end)
            return true
        end
    end,
}

local ok, local_nav = pcall(require, "my_nav_local")
if ok and type(local_nav) == "function" then
    local_nav(M.patterns)
end

function M.handler()
    local filepath = vim.fn.expand("%:p")
    local root = vim.fs.root(0, { ".git" }) or vim.fn.getcwd()

    for _, pattern in ipairs(M.patterns) do
        if pattern(filepath, root) then
            return
        end
    end
end

return M
