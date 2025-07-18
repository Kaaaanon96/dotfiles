
local myvimrc_path = vim.env.MYVIMRC
local myvimrc_dir = vim.fn.fnamemodify(myvimrc_path, ":h")

--[[
###############
vimから持ってきたコピペ設定読み込み
###############
]]
local nvim_rc_vim_path = myvimrc_dir .. "/nvim-rc.vim"

vim.cmd("source " .. nvim_rc_vim_path)

--[[
###############
nvim個別設定
###############
]]

vim.cmd("language ja_JP.UTF-8")
vim.opt.fileencoding = "utf-8"
vim.opt.mouse = ""

-- C-uはプラグインで利用するので無効化。合わせてC-dも無効化。
vim.keymap.set("n", "<C-u>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "<Nop>", { noremap = true, silent = true })


--[[
###############
plugin: lazy.nvim管理
###############
]]

-- ./lua/config/lazy.lua
require("config.lazy")
