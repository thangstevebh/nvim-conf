-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = "\\"
local opt = vim.opt

vim.wo.number = true
vim.scriptencoding = "utf-8"

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.shell = "zsh"
opt.winblend = 0
opt.spell = true
opt.spelloptions = "camel"

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = "#A6E22E", bg = nil, bold = true })
