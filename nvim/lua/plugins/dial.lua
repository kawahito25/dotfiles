return {
    "monaqa/dial.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        local augend = require("dial.augend")
        local default = {
            augend.integer.alias.decimal_int,
            augend.constant.alias.bool,
            augend.constant.alias.Bool,
            augend.constant.new({ elements = { "and", "or" }, word = true, cyclic = true }),
            augend.constant.new({ elements = { "&&", "||" }, word = false, cyclic = true }),
            augend.date.new({ pattern = "%Y/%m/%d", default_kind = "day", only_valid = true, }),
            augend.date.new({ pattern = "%Y-%m-%d", default_kind = "day", only_valid = true, }),
        }
        require("dial.config").augends:register_group {
            default = default,
        }
        require("dial.config").augends:on_filetype {
            ruby = vim.list_extend({
                augend.constant.new({ elements = { "if", "unless" }, word = true, cyclic = true }),
            }, default)
        }
        vim.keymap.set("n", "<C-e>", require("dial.map").inc_normal(), { noremap = true })
        vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
    end
}
