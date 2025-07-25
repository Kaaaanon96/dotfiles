
local myvimrc_path = vim.env.MYVIMRC
local myvimrc_dir = vim.fn.fnamemodify(myvimrc_path, ":h")

--------------------------------------------------------
-- vimから持ってきたコピペ設定読み込み
--------------------------------------------------------
local nvim_rc_vim_path = myvimrc_dir .. "/nvim-rc.vim"

vim.cmd("source " .. nvim_rc_vim_path)

--------------------------------------------------------
-- nvim settings
--------------------------------------------------------
local opt = vim.opt

vim.cmd("language ja_JP.UTF-8")
opt.fileencoding = "utf-8"

opt.mouse = ""
opt.autoindent = true
opt.smartindent = true
opt.cindent = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 0

--------------------------------------------------------
-- mappings
--------------------------------------------------------
local keyset = vim.keymap.set

-- C-uはプラグインで利用するので無効化。合わせてC-dも無効化。
keyset("n", "<C-u>", "<Nop>", { noremap = true, silent = true })
keyset("n", "<C-d>", "<Nop>", { noremap = true, silent = true })


-- 'osyo-manga/vim-over'でやっていた置換ハイライト
opt.inccommand = "split"
keyset("n", "<Space>o", ":%s///g<Left><Left>", {})
keyset("v", "<Space>o", ":s///g<Left><Left>", {})

vim.api.nvim_create_user_command(
  "YankFilename",
  function()
    local filename = vim.fn.fnamemodify(vim.fn.bufname(), ":t")
    vim.fn.setreg("+", filename)
    vim.notify("Copied: " .. filename, vim.log.levels.INFO, { title = "Neovim" })
  end,
  { desc = "yank current file name", nargs = 0 }
)
keyset("n", "<leader>fy", "<Cmd>YankFilename<CR>", { noremap = true, silent = true, desc = "yank current filename" })


----------------------------
-- lsp settings
----------------------------

local lsp_enables = {
  -- "ruby-lsp",
  "solargraph",
  "gopls",

}
vim.lsp.enable(lsp_enables)

-- keymapはfzf.luaも参照(結果をlistで取得できるものはfzf経由で呼び出し)
local configure_lsp = function()
  local lsp_buf = vim.lsp.buf
  local lsp_keyopts = { noremap = true, silent = true }

  keyset("n", "<leader>lr", lsp_buf.rename, lsp_keyopts)
  keyset("n", "<leader>lh", lsp_buf.hover, lsp_keyopts)
  keyset("n", "<leader>lt", lsp_buf.type_definition, lsp_keyopts)
  keyset("n", "<leader>ls", lsp_buf.signature_help, lsp_keyopts)

  keyset("n", "<leader>lf", lsp_buf.format, lsp_keyopts)
  keyset("v", "<leader>lf", lsp_buf.format, lsp_keyopts)
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup("MyLspConfig", {}),
  callback = configure_lsp
})

----------------------------
-- plugin: lazy.nvim管理
----------------------------

-- ./lua/config/lazy.lua
require("config.lazy")

