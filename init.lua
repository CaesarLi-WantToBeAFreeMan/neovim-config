--set leader keys
vim.g.mapleader = "\\"         --define the global leader key
vim.g.maplocalleader = "\\"    --define the local leader key

--load configuration modules
require "config.options"       --import options
require "config.keymaps"       --import custom key mappings
require "config.lazy"          --import LazyVim plugin manager setup
