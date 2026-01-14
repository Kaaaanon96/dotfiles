-- Git系色々
return {
  -- https://github.com/lewis6991/gitsigns.nvim
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = "BufRead",
    keys = {
      {"[c", "<Cmd>Gitsigns nav_hunk prev<CR>", { desc="jump prev hunk" }},
      {"]c", "<Cmd>Gitsigns nav_hunk next<CR>", { desc="jump next hunk" }},
    },
    config = function()
      vim.api.nvim_create_user_command(
        "Gblame",
        function(opts)
          vim.cmd("Gitsigns blame")
        end,
        {
          desc = "Open Git blame",
          nargs = 0,
        }
      )
    end
  },
  -- https://github.com/sindrets/diffview.nvim
  {
    "sindrets/diffview.nvim",
    lazy = true,
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    opts = {
      view = {
        merge_tool = {
          layout = "diff4_mixed",   -- 4分割(下段編集)レイアウト
          disable_diagnostics = true,
        },
      },
    },
    config = function (_, opts)
      require("diffview").setup(opts)

      vim.api.nvim_create_user_command(
        "Gdiff",
        function(opts)
          local args_str = table.concat(opts.fargs, " ")

          if args_str == "" then
            vim.cmd("DiffviewOpen")
          else
            vim.cmd("DiffviewOpen" .. args_str)
          end
        end,
        {
          desc = "Open Diffview(e.g. :Gdiff HEAD~1, :Gdiff origin/main...HEAD, :Gdiff)",
          nargs = "*",
        }
      )

      vim.api.nvim_create_user_command(
        "Glog",
        function(opts)
          vim.cmd("DiffviewFileHistory %")
        end,
        {
          desc = "Open DiffviewFileHistory for current file",
          nargs = 0,
        }
      )
    end
  },
  -- https://github.com/NeogitOrg/neogit
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required

      "sindrets/diffview.nvim",        -- optional - Diff integration
      "ibhagwan/fzf-lua",              -- optional
    },
  },
}
