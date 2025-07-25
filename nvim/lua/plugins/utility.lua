-- 便利系で設定複雑じゃないやつ全部
return {
  -- 自動でカッコとかdoとか閉じてくれるやつ
  {
    "cohama/lexima.vim",
    lazy = true,
    event = "BufRead",
  },
  -- 検索系改善
  {
    "haya14busa/vim-asterisk",
    lazy = true,
    event = "BufRead",
    config = function()
      local keyset = vim.keymap.set
      keyset('', '*', '<Plug>(asterisk-z*)<Plug>(is-nohl-1)', {})
      keyset('', 'g*', '<Plug>(asterisk-gz*)<Plug>(is-nohl-1)', {})
      keyset('', '#', '<Plug>(asterisk-z#)<Plug>(is-nohl-1)', {})
      keyset('', 'g#', '<Plug>(asterisk-gz#)<Plug>(is-nohl-1)', {})
    end,
    dependencies = {
      "haya14busa/is.vim"
    },
  },
  -- 置換(inccommandは微妙に挙動違うから合わなければこっちに戻す)
  --[[
  {
    "osyo-manga/vim-over"
    lazy = true
    keys = {
      {"<Space>o", "<Cmd>OverCommandLine<CR>%s///g<Left><Left>", { mode="n" }}
      {"<Space>o", "<Cmd>OverCommandLine<CR>s///g<Left><Left>", { mode="v" }}
    },
  },
  ]]
}
