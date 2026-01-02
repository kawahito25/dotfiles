-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Git管理しない local_plugins を任意で読み込む
local spec_list = {
    { import = "plugins" },
}
if vim.fn.isdirectory(vim.fn.expand(vim.fn.stdpath("config") .. "/lua/local_plugins")) == 1 then
    table.insert(spec_list, { import = "local_plugins" })
end

-- Setup lazy.nvim
require("lazy").setup({
    spec = spec_list,
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = {
        enabled = true,
        frequency = 3600 * 24 * 30, -- 30日に１回
    },
})
