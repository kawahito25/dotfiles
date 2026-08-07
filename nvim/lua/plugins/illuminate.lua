return {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
        disable_keymaps = true,
    },
    config = function(_, opts)
        local illuminate = require("illuminate")
        illuminate.configure(opts)

        vim.keymap.set({ "x", "o" }, "ir", function()
            illuminate.textobj_select()
        end, { desc = "Illuminate reference" })

        Snacks.toggle({
            name = "Illuminate",
            get = function()
                return not require("illuminate.engine").is_paused()
            end,
            set = function(enabled)
                local m = require("illuminate")
                if enabled then
                    m.resume()
                else
                    m.pause()
                end
            end,
        }):map("<leader>ui")
    end,
}
