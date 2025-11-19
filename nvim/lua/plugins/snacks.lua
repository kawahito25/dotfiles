
-- @see https://github.com/folke/snacks.nvim/discussions/1701#discussioncomment-12934844
local list_extend = function(where, what)
  return vim.list_extend(vim.deepcopy(where), what)
end

local list_filter = function(where, what)
  -- 'what' に含まれる要素を 'where' から取り除く
  -- stylua: ignore
  return vim.iter(where):filter(function(val)
    return not vim.list_contains(what, val)
  end):totable()
end

return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        enabled = true,
        sources = {
          grep = {
            -- 1. カスタム変数を定義 (デフォルトはケースインセンシティブ=false)
            case_sens = false, 
            
            -- 2. finderをオーバーライドして引数処理を追加
            finder = function(opts, ctx)
              local args_extend = { '--case-sensitive' } -- ケースセンシティブにするための引数
              
              -- 既存の引数から、まず'--case-sensitive'を削除
              opts.args = list_filter(opts.args or {}, args_extend) 
              
              -- case_sensがtrueなら、'--case-sensitive'を追加
              if opts.case_sens then 
                opts.args = list_extend(opts.args, args_extend)
              end
              
              -- 元のgrep finderを呼び出す
              return require('snacks.picker.source.grep').grep(opts, ctx)
            end,
            
            -- 3. カスタムアクションを定義
            actions = {
              toggle_live_case_sens = function(picker)
                -- picker.opts.case_sens の状態をトグル
                picker.opts.case_sens = not picker.opts.case_sens
                -- 検索をリフレッシュ
                picker:find() 
                
                -- (オプション) トグルの状態を通知
                local msg = picker.opts.case_sens and "Case Sensitive: ON" or "Case Sensitive: OFF"
                vim.notify(msg, vim.log.levels.INFO, { title = "Snacks Grep" })
              end,
            },
            
            -- 4. キーマップの割り当て
            win = {
              input = {
                keys = {
                  ['<C-s>'] = { 'toggle_live_case_sens', mode = { 'i', 'n' }, desc = 'Toggle Case Sensitive' },
                },
              },
            },
          },
        },
      },
    },
    keys = { 
      -- Top Pickers & Explorer
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
      { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
      { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
      -- find
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
      { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    },
  },
}

