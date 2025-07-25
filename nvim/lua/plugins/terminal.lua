return {
  -- https://github.com/akinsho/toggleterm.nvim
  {
    "akinsho/toggleterm.nvim",
    lazy = false,
    opts = function()
      local status, colors = pcall(function()
        return require("catppuccin.palettes").get_palette("frappe")
      end)

      local float_bg = "#303446"
      local float_accent = "#eebebe"
      if status then
        float_bg = colors.base
        float_accent = colors.flamingo
      end

      return {
        open_mapping = [[<c-\>]],
        direction = 'float',
        start_in_insert = true,
        close_on_exit = true,
        persist_size = true,
        float_opts = {
          border = 'double',
          width = function()
            return math.floor(vim.o.columns*0.7)
          end,
          height = function()
            return math.floor(vim.o.lines*0.75)
          end,
          title_pos = 'left',
        },
        shade_terminals = false,
        highlights = {
          NormalFloat = {
            guibg = float_bg
          },
          FloatBorder = {
            guifg = float_accent,
            guibg = float_bg,
          }
        }
      }
    end,
    config = function(_, opts)
      require("toggleterm").setup(opts)

      local function toggle_terminal_in_direction(direction)
        -- direction = 'vertical' | 'horizontal' | 'tab' | 'float'

        local count = vim.v.count > 0 and vim.v.count or 1
        local formatted_cmd = string.format("%dToggleTerm direction=%s", count, direction)
        vim.cmd(formatted_cmd)
      end

      vim.api.nvim_create_user_command('Fterm', function()
        toggle_terminal_in_direction('float')
      end, { nargs = 0, count = 0, desc = 'Toggle floating terminal (e.g., :2Fterm)' })

      vim.api.nvim_create_user_command('Vterm', function()
        toggle_terminal_in_direction('vertical')
      end, { nargs = 0, count = 0, desc = 'Toggle vertical terminal (e.g., :3Vterm)' })

      vim.api.nvim_create_user_command('Hterm', function()
        toggle_terminal_in_direction('horizontal')
      end, { nargs = 0, count = 0, desc = 'Toggle horizontal terminal (e.g., :4Hterm)' })

      -- ターミナルが開かれた時にキーマップを設定するautocmd
      vim.api.nvim_create_autocmd('TermOpen', {
        pattern = 'term://*',
        desc = 'Set keymaps for toggleterm terminal',
        callback = function()
          local mapset = vim.keymap.set
          mapset('t', '<esc>', [[<C-\><C-n>]], { buffer = 0, noremap = true })
        end,
      })
    end,
  },
}
