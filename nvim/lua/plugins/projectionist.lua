return {
    -- {
    --     "tpope/vim-projectionist",
    --     commands = { "A", "AV", "AS", "AT" },
    --     config = function()
    --         vim.g.projectionist_heuristics = {
    --             -- プロジェクト内に「spec/」ディレクトリがある場合に適用
    --             ["spec/"] = {
    --                 ["app/*.rb"] = { alternate = "spec/{}_spec.rb" },
    --                 ["spec/*_spec.rb"] = { alternate = "app/{}.rb" },
    --                 ["lib/*.rb"] = { alternate = "spec/lib/{}_spec.rb" },
    --                 ["spec/lib/*_spec.rb"] = { alternate = "lib/{}.rb" }
    --             },
    --         }
    --     end,
    -- },
    {
        "tpope/vim-rails",
        ft = { "ruby", "rspec" },
    },
}
