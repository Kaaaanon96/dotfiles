return {
  -- https://github.com/neovim/nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = "BufReadPre",
    -- 設定はinit.luaとfzf.lua参照
  },
}
