--bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

--check if lazy.nvim is already installed
if not vim.loop.fs_stat(lazypath) then
    --clone latest stable release of lazyvim from GitHub to lazypath
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",--do not download unnecessary files
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",--use stable branch
        lazypath,
    })
end

--add lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

--lazy.nvim options
local opts = {
    --border style
    ui = {border = "rounded"},
    --do not automatically check for updates
    checker = {enabled = false},
    --do not notify when configure file changes
    change_detection = {notify = false},
}

--setup lazy.nvim
require("lazy").setup("plugin", opts)--load all files in lua/plugin/
