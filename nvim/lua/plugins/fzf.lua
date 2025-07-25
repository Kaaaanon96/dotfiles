return {
  -- https://github.com/ibhagwan/fzf-lua
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
        -- コマンド用に設定している環境変数を無視
        fzf_opts_env = false,
        fzf_opts = {
          ["--no-mouse"] = true
        },
        winopts = {
          width = 0.9,
          height = 0.75,
          border = "rounded",
          preview = {
            default = "bat",
            layout = "horizontal",
            horizontal = 'right:50%',
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
        },
        lsp = {
          prompt = "Lsp> ",
          jump1_action = fzf_actions.file_vsplit,
        },
        keymaps = {
          prompt = "Keymaps> ",
          winopts = {
            width = 0.5,
            height = 0.5,
            row = 0.5,
            col = 0.5,
            preview = {
              hidden = true,
            },
          },
        },
        builtin = {
          prompt = "builtin❯ ",
          winopts = {
            width = 0.5,
            height = 0.5,
            row = 0.5,
            col = 0.5,
          },
        },
      }
    end,
    config = function (_, opts)
      require("fzf-lua").setup(opts)

      local configure_lsp_fzf = function()
        local keyset = vim.keymap.set
        keyset('n', '<leader>ll', '<Cmd>FzfLua lsp_finder<CR>', { silent = true, desc = 'fzf: search lsp combine view' })

        keyset('n', '<leader>l]', '<Cmd>FzfLua lsp_references<CR>', { silent = true, desc = 'fzf: search lsp references' })

        keyset('n', '<leader>ld', '<Cmd>FzfLua lsp_definitions<CR>', { silent = true, desc = 'fzf: search lsp definitions' })
        keyset('n', '<leader>lt', '<Cmd>FzfLua lsp_typedefs<CR>', { silent = true, desc = 'fzf: search lsp type definitions' })

        keyset('n', '<leader>li', '<Cmd>FzfLua lsp_implementations<CR>', { silent = true, desc = 'fzf: search lsp implementations' })
        keyset('n', '<leader>lsd', '<Cmd>FzfLua lsp_document_symbols<CR>', { silent = true, desc = 'fzf: search lsp symbol in current buffer' })
        keyset('n', '<leader>lsw', '<Cmd>FzfLua lsp_workspace_symbols<CR>', { silent = true, desc = 'fzf: search lsp symbol in workspace' })

        keyset('n', '<leader>lci', '<Cmd>FzfLua lsp_incoming_calls<CR>', { silent = true, desc = 'fzf: search lsp incoming calls list' })
        keyset('n', '<leader>lco', '<Cmd>FzfLua lsp_outgoing_calls<CR>', { silent = true, desc = 'fzf: search lsp outgoint calls list' })

        keyset('n', '<leader>lp', '<Cmd>FzfLua diagnostics_document<CR>', { silent = true, desc = 'fzf: search lsp diagnostics list' })

        keyset('n', '<leader>la', '<Cmd>FzfLua lsp_code_actions<CR>', { silent = true, desc = 'fzf: search lsp code actions' })
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup("MyFzfLspConfig", {}),
        callback = configure_lsp_fzf
      })
    end,
  }
}
