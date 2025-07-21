-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = "\\"
local opt = vim.opt

vim.wo.number = true

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
vim.scriptencoding = "utf-8"

opt.shell = "zsh"

opt.winblend = 0
opt.pumblend = 5
opt.cursorline = true
opt.termguicolors = true
opt.wildoptions = "pum"
opt.foldenable = true

opt.spelllang = "en_us"
opt.spell = true
opt.spelloptions = "camel"

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })
