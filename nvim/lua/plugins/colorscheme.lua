return {
  -- add catppuccin
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "macchiato",
      transparent_background = true,
      integrations = {
        diffview = true,
        fern = true,
        copilot_vim = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  --[[
  {
    "folke/tokyonight.nvim",
    lazy = true,
    name = "tokyonight"
  }
  ]]
}
