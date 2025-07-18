-- https://github.com/lambdalisue/vim-fern
return {
  -- fernと関連するプラグインの設定
  {
    "lambdalisue/fern.vim",
    lazy = false,
    config = function()
      -- plug.rc.vimの内容をluaで移植しただけ
      -- nmapもnnoremapで書いてる。nmapにしたい場合はoptに`remap = true`を指定
      vim.g["fern#disable_default_mappings"] = 1
      vim.g["fern#default_hidden"] = 1
      vim.g["fern#default_exclude"] = '\\.DS_Store\\|\\.localized'

      local keyset = vim.keymap.set

      -- keyset('n', '<C-e>', '<Cmd>Fern . -drawer<CR>', { silent = true, desc = 'Toggle Fern drawer' })
      keyset('n', '<leader>vf', '<Cmd>vsp<CR><Cmd>Fern . -reveal=%<CR>', { desc = 'Vertical split and reveal in Fern' })
      keyset('n', '<leader>f', '<Cmd>Fern . -reveal=%<CR>', { desc = 'Reveal current file in Fern' })

      local configure_fern = function()
        keyset('n', '<C-c>', '<Plug>(fern-action-cancel)', { buffer = true, silent = true, desc = 'Fern: Cancel' })
        keyset('n', '<C-l>', '<Plug>(fern-action-redraw)', { buffer = true, silent = true, desc = 'Fern: Redraw' })
        keyset('n', '<C-r>', '<Plug>(fern-action-reload)', { buffer = true, silent = true, desc = 'Fern: Reload' })
        keyset('n', '-', '<Plug>(fern-action-mark:toggle)', { buffer = true, silent = true, desc = 'Fern: Toggle mark' })

        local fern_toggle_or_open = function()
          return vim.fn['fern#smart#leaf'](
            '<Plug>(fern-action-open)',
            '<Plug>(fern-action-expand)',
            '<Plug>(fern-action-collapse)'
          )
        end
        keyset('n', '<Plug>(my-fern-toggle-or-open)', fern_toggle_or_open, {
          expr = true, buffer = true, silent = true, desc = 'Fern: Smart Toggle/Open Plug Map'
        })
        keyset('n', '<C-m>', '<Plug>(my-fern-toggle-or-open)', { buffer = true, silent = true, desc = 'Fern: Smart Toggle/Open' })
        keyset('n', '<CR>', '<Plug>(my-fern-toggle-or-open)', { buffer = true, silent = true, desc = 'Fern: Smart Toggle/Open' })

        local fern_expand_or_enter = function()
          return vim.fn['fern#smart#drawer'](
            '<Plug>(fern-action-open-or-expand)',
            '<Plug>(fern-action-open-or-enter)'
          )
        end
        keyset('n', '<Plug>(my-fern-expand-or-enter)', fern_expand_or_enter, {
          expr = true, buffer = true, silent = true, desc = 'Fern: Smart Expand/Enter Plug Map'
        })
        keyset('n', 'l', '<Plug>(my-fern-expand-or-enter)', { buffer = true, silent = true, desc = 'Fern: Smart Expand/Enter' })

        local fern_collapse_or_leave = function()
          return vim.fn['fern#smart#drawer'](
            '<Plug>(fern-action-collapse)',
            '<Plug>(fern-action-leave)'
          )
        end
        keyset('n', '<Plug>(my-fern-collapse-or-leave)', fern_collapse_or_leave, {
          expr = true, buffer = true, silent = true, desc = 'Fern: Smart Collapse/Leave Plug Map'
        })
        keyset('n', 'h', '<Plug>(my-fern-collapse-or-leave)', { buffer = true, silent = true, desc = 'Fern: Smart Collapse/Leave' })

        keyset('n', 'o', '<Plug>(fern-action-open:select)', { buffer = true, silent = true, desc = 'Fern: Open/Select' })
        keyset('n', 'i', '<Plug>(fern-action-open:split)', { buffer = true, silent = true, desc = 'Fern: Open in split' })
        keyset('n', 's', '<Plug>(fern-action-open:vsplit)', { buffer = true, silent = true, desc = 'Fern: Open in vertical split' })

        vim.keymap.set('n', 'mo', '<Plug>(fern-action-open:system)', { buffer = true, silent = true, desc = 'Fern: Open in system app' })
        vim.keymap.set('n', 'ma', '<Plug>(fern-action-new-path)', { buffer = true, silent = true, desc = 'Fern: New path (file/dir)' })
        vim.keymap.set('n', 'mk', '<Plug>(fern-action-new-dir)', { buffer = true, silent = true, desc = 'Fern: New directory' })
        vim.keymap.set('n', 'mc', '<Plug>(fern-action-copy)', { buffer = true, silent = true, desc = 'Fern: Copy' })
        vim.keymap.set('n', 'mm', '<Plug>(fern-action-move)', { buffer = true, silent = true, desc = 'Fern: Move' })
        vim.keymap.set('n', 'mr', '<Plug>(fern-action-rename)', { buffer = true, silent = true, desc = 'Fern: Rename' })
        vim.keymap.set('n', 'md', '<Plug>(fern-action-trash)', { buffer = true, silent = true, desc = 'Fern: Move to trash' })
        vim.keymap.set('n', 'my', '<Plug>(fern-action-yank:label)', { buffer = true, silent = true, desc = 'Fern: Yank label' })

        local fern_quit_or_nop = function()
          return vim.fn['fern#smart#drawer'](':<C-u>quit<CR>', '')
        end
        vim.keymap.set('n', '<Plug>(my-fern-quit-or-nop)', fern_quit_or_nop, {
          expr = true, buffer = true, silent = true, desc = 'Fern: Smart Quit/No-op'
        })
        vim.keymap.set('n', 'q', '<Plug>(my-fern-quit-or-nop)', { buffer = true, silent = true, desc = 'Fern: Quit drawer or no-op' })
      end

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('MyFern', {}),
        pattern = 'fern',
        desc = 'Fern上の設定をFernが開いたタイミングで適用',
        callback = configure_fern
      })
    end,
    dependencies = {
      {
        "lambdalisue/fern-git-status.vim",
      }
    }
  },
}
