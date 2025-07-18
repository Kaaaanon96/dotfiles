-- https://github.com/ibhagwan/fzf-lua
return {
  {
    "ibhagwan/fzf-lua",
    lazy = false,
    opts = function()
      -- nvim binds
      local keyset = vim.keymap.set

      keyset('n', '<C-u><C-r>', '<Cmd>FzfLua resume<CR>', { silent = true, desc = 'fzf: resume last command/query' })

      keyset('n', '<C-u><C-p>', '<Cmd>FzfLua files<CR>', { silent = true, desc = 'fzf: search filename' })
      keyset('n', '<C-u><C-g>', '<Cmd>FzfLua grep_project<CR>', { silent = true, desc = 'fzf: search full text' })
      keyset('n', '<C-u><C-j>', '<Cmd>FzfLua blines<CR>', { silent = true, desc = 'fzf: search current buffer line' })
      keyset('n', '<C-u><C-b>', '<Cmd>FzfLua buffers<CR>', { silent = true, desc = 'fzf: search nvim open buffer' })
      keyset('n', '<C-u><C-u>', '<Cmd>FzfLua git_status<CR>', { silent = true, desc = 'fzf: search git status files' })

      keyset('n', '<C-u><C-a>', '<Cmd>lua require("fzf-lua").grep({ search = "" })<CR>', { silent = true, desc = 'fzf: full text && file name search' })

      local rb_search_cmd = '<Cmd>lua require("fzf-lua").grep({ no_esc=true, search=" -- *.rb !.git/*" , fzf_opts={["--nth"]="2.."}})<CR>'
      keyset('n', '<C-u><C-w><C-r>', rb_search_cmd, { silent = true, desc = 'fzf: ruby file full search' })

      keyset('n', '<C-u><C-n>', '<Cmd>FzfLua commands<CR>', { silent = true, desc = 'fzf: search neovim commands' })
      keyset('n', '<C-u><C-h>', '<Cmd>FzfLua command_history<CR>', { silent = true, desc = 'fzf: search command history' })


      -- fzf settings
      local fzf_config = require("fzf-lua").config
      local fzf_actions = require("fzf-lua").actions
      local actions_dict = {
        files = {
          ["enter"] = fzf_actions.file_edit,
          ["ctrl-i"] = fzf_actions.file_split,
          ["ctrl-v"] = fzf_actions.file_vsplit,
        }
      }

      return {
        winopts = {
          width = 0.9,
          height = 0.75,
          preview = {
            default = "bat",
            layout = "horizontal",
            horizontal = 'right:50%'
          },
        },
        keymap = {
          fzf = {
            true,
            ["ctrl-f"] = "forward-char",
            ["ctrl-b"] = "backward-char",
          }
        },
        actions = actions_dict,
        files = {
          cmd = 'rg --files --hidden --follow --no-ignore --glob "!.git/*"',
          -- opt設定してるけど実際に動くコマンドは上固定
          rg_opts = [[--files --hidden --follow --no-ignore --glob "!.git/*"]],
        },
        grep = {
          prompt = 'Rg❯ ',
          cmd = [[rg --column --line-number --hidden --ignore-case --no-heading --color=always --glob "!.git/*" -e]],
          rg_opts = [[--column --line-number --hidden --ignore-case --no-heading --color=always --glob "!.git/*" -e]],
          hidden = true,
          no_ignore = false,
          actions = {
            ["ctrl-g"] = ''
          }
        }
      }
    end,
  }
}
