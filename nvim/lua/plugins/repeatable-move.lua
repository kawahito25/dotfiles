local function to_move_next(q)
    return function()
        require("nvim-treesitter-textobjects.move").goto_next_start(q, "textobjects")
    end
end

local function to_move_prev(q)
    return function()
        require("nvim-treesitter-textobjects.move").goto_previous_start(q, "textobjects")
    end
end

local function hunk_next()
    if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
    else
        require("gitsigns").nav_hunk("next", { target = "all" })
    end
end

local function hunk_prev()
    if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
    else
        require("gitsigns").nav_hunk("prev", { target = "all" })
    end
end

return {
    "kiyoon/repeatable-move.nvim",
    keys = { ";", ",", "]h", "[h", "]f", "[f", "]r", "[r" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "lewis6991/gitsigns.nvim",
        "RRethy/vim-illuminate"
    },
    config = function()
        local repeatable_move = require("repeatable_move")
        local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
        local make_pair = repeatable_move.make_repeatable_move_pair

        local illuminate = require("illuminate")
        local next_ref, prev_ref = repeatable_move.make_repeatable_move_pair(
            function() illuminate.goto_next_reference(true) end,
            function() illuminate.goto_prev_reference(true) end
        )

        -- ; と , でリピートできるようにマッピング
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

        -- illuminate
        vim.keymap.set({ "n", "x", "o" }, "]r", next_ref, { desc = "Next Reference (Illuminate)" })
        vim.keymap.set({ "n", "x", "o" }, "[r", prev_ref, { desc = "Prev Reference (Illuminate)" })

        -- Hunk (]h / [h)
        local next_hunk, prev_hunk = make_pair(hunk_next, hunk_prev)
        vim.keymap.set({ "n", "x", "o" }, "]h", next_hunk, { desc = "next hunk" })
        vim.keymap.set({ "n", "x", "o" }, "[h", prev_hunk, { desc = "prev hunk" })

        -- Function (]f / [f)
        local next_f, prev_f = make_pair(to_move_next("@function.outer"), to_move_prev("@function.outer"))
        vim.keymap.set({ "n", "x", "o" }, "]f", next_f, { desc = "Next function" })
        vim.keymap.set({ "n", "x", "o" }, "[f", prev_f, { desc = "Prev function" })

        -- make builtin f, F, t, T also repeatable with ; and ,
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
    end,
}
