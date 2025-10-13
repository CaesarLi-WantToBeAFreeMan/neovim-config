--set leader keys first
vim.g.mapleader = "\\"          --global leader key
vim.g.maplocalleader = "\\"     --local leader key

require("config.options")       --load options
require("config.keymaps")       --load keymaps
require("config.lazy")          --load LazyVim plugin manager setup
