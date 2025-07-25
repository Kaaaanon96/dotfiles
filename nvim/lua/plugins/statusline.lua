-- StatusLine
return {
  -- https://github.com/nvim-lualine/lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    priority = 100,
    opts = {
      options = {
        theme = "catppuccin"
      },
    },
    dependencies = {
      -- priority付きで初期読み込みされてはいる
      "nvim-tree/nvim-web-devicons"
    },
  },
}
