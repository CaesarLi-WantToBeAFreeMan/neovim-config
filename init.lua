--set leader keys
vim.g.mapleader = "\\" --global leader key
vim.g.maplocalleader = "\\" --local leader key for buffer-specific

--load configuration modules
require("config.options") --options
require("config.autocmds") --auto commands
require("config.keymaps") --custom key mappings
require("config.lazy") --initialize lazyVim plugin manager
