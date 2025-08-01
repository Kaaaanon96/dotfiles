return {
  -- https://github.com/CopilotC-Nvim/CopilotChat.nvim
  {
    --[[
    "CopilotC-Nvim/CopilotChat.nvim",
    lazy = true,
    event = "BufRead",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    ]]
  },
}
