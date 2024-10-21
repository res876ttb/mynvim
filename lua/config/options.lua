-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- Disable auto formatting set by lazyvim
vim.g.autoformat = false

-- Disable relative number set by lazyvim
opt.relativenumber = false

-- Set tab size to 4
opt.tabstop = 4
