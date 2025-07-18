return {
  -- add catppuccin
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "macchiato",
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme "catppuccin"
    end,
  }

  -- 他にも追加する場合は以下にいれて良いはず。
}
