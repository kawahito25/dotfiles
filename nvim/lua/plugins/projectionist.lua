return {
    {
        "tpope/vim-projectionist",
        event = "VeryLazy",
        commands = { "A", "AV", "AS", "AT" },
        config = function()
            vim.g.projectionist_heuristics = {
                -- プロジェクト内に「spec/」ディレクトリがある場合に適用
                ["spec/"] = {
                    ["app/*.rb"] = { alternate = "spec/{}_spec.rb" },
                    ["spec/*_spec.rb"] = { alternate = "app/{}.rb" },
                    ["lib/*.rb"] = { alternate = "spec/lib/{}_spec.rb" },
                    ["spec/lib/*_spec.rb"] = { alternate = "lib/{}.rb" }
                },
                ["go.mod"] = {
                    ["*.go"] = {
                        alternate = "{}_test.go",
                        type = "source",
                    },
                    ["*_test.go"] = {
                        alternate = "{}.go",
                        type = "test",
                    },
                },
            }
        end,
    },
}
